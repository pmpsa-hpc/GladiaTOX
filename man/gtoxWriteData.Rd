% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtoxWriteData.R
\name{gtoxWriteData}
\alias{gtoxWriteData}
\title{Write screening data into the gtox databases}
\usage{
gtoxWriteData(dat, lvl, type)
}
\arguments{
\item{dat}{data.table, the screening data to load}

\item{lvl}{Integer of length 1, the data processing level}

\item{type}{Character of length 1, the data type, "sc" or "mc"}
}
\value{
None
}
\description{
\code{gtoxWriteData} takes a data.table with screening data and writes the
data into the given level table in the gtox databases.
}
\details{
This function appends data onto the existing table. It also deletes all the
data for any acids or aeids dat contains from the given and all downstream
tables.

The data type can be either 'mc' for mutliple concentration data, or 'sc'
for single concentration data. Multiple concentration data will be loaded
into the level tables, whereas the single concentration will be loaded into
the single tables.
}
\examples{

\dontrun{
## Load sample data
load(system.file("extdata", "data_for_vignette.rda", package="GladiaTOX"))

# Build assay table
assay <- buildAssayTab(plate, chnmap)

## Set study parameters
std.nm <- "SampleStudy" # study name
phs.nm <- "PhaseII" # study phase

## Load annotation in gtoxDB
loadAnnot(plate, assay, NULL)

## Get the created study ID
asid = gtoxLoadAsid(fld = c("asnm", "asph"), val = list(std.nm, phs.nm))$asid

## Prepare and load data
dat <- prepareDatForDB(asid, dat)
gtoxWriteData(dat[ , list(acid, waid, wllq, rval)], lvl = 0, type = "mc")
}

}
\seealso{
\code{\link{gtoxCascade}}, \code{\link{gtoxAppend}}
}
