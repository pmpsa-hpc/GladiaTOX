% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/exportResultTable.R
\name{exportResultTable}
\alias{exportResultTable}
\title{Create the result table for the asi in input}
\usage{
exportResultTable(asid, stats, outfile)
}
\arguments{
\item{asid}{Assay source id}

\item{stats}{Statistics to export}

\item{outfile}{Path to the output file}
}
\value{
None
}
\description{
This function export results
}
\details{
This funtion is useful to export results in a table format
}
\examples{

outfile <- "export_stats.csv"
exportResultTable(asid=1L, stats=c("modl_acc", "modl_ga"), outfile=outfile)

}
