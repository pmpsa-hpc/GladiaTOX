% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtoxPlotFits.R
\name{gtoxPlotFits}
\alias{gtoxPlotFits}
\title{Plot summary fits based on fit and dose-response data}
\usage{
gtoxPlotFits(dat, agg, flg = NULL, ordr.fitc = FALSE, bline = "bmad")
}
\arguments{
\item{dat}{data.table, level 4 or level 5 data, see details.}

\item{agg}{data.table, concentration-response aggregate data, see details.}

\item{flg}{data.table, level 6 data, see details.}

\item{ordr.fitc}{Logical, should the fits be ordered by fit category?}

\item{bline}{Character of length 1, the value used for drawing the baseline
noise}
}
\value{
None
}
\description{
\code{gtoxPlotFits} takes the dose-response and fit data and produces
summary plot figures.
}
\details{
The data for 'dat', 'agg', and 'flg' should be loaded using the
\code{\link{gtoxLoadData}} function with the appropriate 'lvl' parameter.
See help page for \code{gtoxLoadData} for more information.

Supplying level 4 data for the 'dat' parameter will result in level 4 plots.
Similarly, supp

If fits are not ordered by fit category, they will be ordered by chemical
ID. Inputs with multiple assay endpoints will first be ordered by assay
endpoint ID.

Any values for 'bline' other than 'coff' will use 3*bmad.
}
\examples{

## Store the current config settings, so they can be reloaded at the end
## of the examples
conf_store <- gtoxConfList()
gtoxConfDefault()

## gtoxPlotFits needs data.tables supplying the concentration/response
## data stored in mc4_agg, as well as the fit information from mc4 or mc5.
## Additionally, gtoxPlotFits will take level 6 data from mc6 and add the
## flag information to the plots. The following shows how to make level 6
## plots. Omitting the 'flg' parameter would result in level 5 plots, and
## loading level 4, rather than level 5 data, would result in level 4 plots.

aeid = 2
l5 <- gtoxLoadData(lvl = 5, fld = "aeid", val = aeid)
l4_agg <- gtoxLoadData(lvl = "agg", fld = "aeid", val = aeid)
l6 <- gtoxLoadData(lvl = 6, fld = "aeid", val = aeid)
\dontrun{
pdf(file = "gtoxPlotFits.pdf", height = 6, width = 10, pointsize = 10)
gtoxPlotFits(dat = l5, agg = l4_agg, flg = l6)
graphics.off()
}

## While it is most likely the user will want to just save all of the plots
## to view in a PDF, the 'browse' parameter can be used to quickly view
## some plots.

## Start by identifying some sample IDs to plot, then call gtoxPlotFits with
## a subset of the data. This browse function is admittedly clunky.
bpa <- gtoxLoadChem(field = "chnm", val = "chromium")[ , spid]
l5_sub <- l5[spid \%in\% bpa]

gtoxPlotFits(dat = l5_sub, agg = l4_agg[m4id \%in\% l5_sub$m4id])


## Reset configuration
options(conf_store)

}
