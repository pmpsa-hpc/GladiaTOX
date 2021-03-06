#####################################################################
## This program is distributed in the hope that it will be useful, ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of  ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the    ##
## GNU General Public License for more details.                    ##
#####################################################################

#-------------------------------------------------------------------------------
# prepareDatForDB: prepare dat file to be loaded in database prior processing
#-------------------------------------------------------------------------------

#' @title Assign default processing methods
#' @description This function is a wrapper to ease the creation of the 
#' dataframe containing data and metadata to be loaded in the database
#' 
#' @param asid Integer, the asid value(s) to assign the default methods to
#' @param dat Data.table containing metadata and data to load in DB
#' 
#' @details 
#' This function formats a dat table to be loaded in DB
#' 
#' @examples
#' 
#' \dontrun{
#' ## Load sample data
#' load(system.file("extdata", "data_for_vignette.rda", package="GladiaTOX"))
#' 
#' # Build assay table
#' assay <- buildAssayTab(plate, chnmap)
#' 
#' ## Set study parameters
#' std.nm <- "SampleStudy" # study name
#' phs.nm <- "PhaseII" # study phase
#' 
#' ## Delete previously loaded study data
#' asid = gtoxLoadAsid(fld=c("asnm", "asph"), val=list(std.nm, phs.nm))$asid
#' if(length(asid)>0){ deleteStudy(asid=asid) }
#' 
#' ## Load annotation in gtoxDB
#' loadAnnot(plate, assay, NULL)
#' 
#' ## Get the created study ID
#' asid = gtoxLoadAsid(fld = c("asnm", "asph"), val = list(std.nm, phs.nm))$asid
#' 
#' ## Prepare and load data
#' dat <- prepareDatForDB(asid, dat)
#' }
#' 
#' @return Data table with data and metadata to store in database
#' 
#' @import data.table
#' @export
#' 

prepareDatForDB <- function(asid, dat) {
    
    # Prepare data for loading into the database
    acid_map <- gtoxLoadAcid("asid", asid, c("aid", "machine_name"))
    well_dat <- gtoxLoadWaid("aid", acid_map[ , unique(aid)])
    setkey(well_dat, u_boxtrack, coli, rowi)
    setkey(dat, u_boxtrack, coli, rowi)
    dat <- well_dat[dat]
    setkey(acid_map, aid, machine_name)
    setkey(dat, aid, machine_name)
    dat <- acid_map[dat, nomatch = 0]
    dat[ , rval := measure_val]
    dat[ , wllq := 1]
    
    return(dat)
}
