#####################################################################
## This program is distributed in the hope that it will be useful, ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of  ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the    ##
## GNU General Public License for more details.                    ##
#####################################################################

#-------------------------------------------------------------------------------
# gtoxCalcVmad: Calculate and update the assay endpoint cutoff values
#-------------------------------------------------------------------------------

#' @title Calculate and update the assay endpoint cutoff values
#'
#' @description
#' \code{gtoxCalcVmad} takes the input aeid values and uses them to calculate
#' the assay endpoint cutoff based on the median absolute deviation of vehicle
#' values across the given assay endpoints.
#'
#' @param inputs integer, the aeid(s) used to calculate the cutoff values
#' @param aeid integer, the aeid(s) to be updated in the database
#' @param notes character of length 1, (optional) comments/justification
#'
#' @details
#' If 'aeid' is NULL, the value will be returned with no changes made to the
#' database.
#'
#' Cutoffs are caluted as the median absolute value of the vehicle values
#' across the assay endpoints given by 'inputs'.
#'
#' @examples
#' ## Store the current config settings, so they can be reloaded at the end 
#' ## of the examples
#' conf_store <- gtoxConfList()
#' gtoxConfDefault()
#' 
#' ## Prepare for analysis before QC + process data
#' gtoxCalcVmad(inputs = 10L)
#' 
#' ## Reset configuration
#' options(conf_store)
#' 
#' @return None
#' 
#' @import data.table
#' @export

gtoxCalcVmad <- function(inputs, aeid=NULL, notes=NULL) {

    stopifnot(is.integer(inputs))
    stopifnot(is.integer(aeid) | is.null(aeid))
    stopifnot(is.character(notes) | length(notes) == 1 | is.null(notes))

    inputs <- unique(inputs)
    aeid <- unique(aeid)

    dat <- gtoxLoadData(lvl=3, fld="aeid", val=inputs)
    nveh <- dat[wllt == "n", .N]
    if (nveh < 1) stop("No vehicle data for the given inputs.")

    val <- dat[ , mad(resp[wllt == "n"])]

    if (is.null(aeid)) return(val)

    db <- getOption("TCPL_DB")
    gtoxDelete(
        tbl="assay_component_endpoint_vmad",
        fld="aeid",
        val=aeid,
        db=db
    )
    gtoxCascade(lvl=5, type="mc", id=aeid)
    clps <- paste(inputs, collapse=";")
    out <- data.table(aeid=aeid, vmad=val, notes=notes, inputs=clps)
    gtoxAppend(dat=out, tbl="assay_component_endpoint_vmad", db=db)

}

#-------------------------------------------------------------------------------
