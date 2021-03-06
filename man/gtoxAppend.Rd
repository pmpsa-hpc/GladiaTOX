% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtoxAppend.R
\name{gtoxAppend}
\alias{gtoxAppend}
\title{Append rows to a table}
\usage{
gtoxAppend(dat, tbl, db)
}
\arguments{
\item{dat}{data.table, the data to append to a table}

\item{tbl}{Character of length 1, the table to append to}

\item{db}{Character of length 1, the database containing \code{tbl}}
}
\value{
None
}
\description{
\code{gtoxAppend} takes a data.table (dat) and appends the data.table into
a database table.
}
\note{
This function is not exported and not intended to be used by the user.
}
\keyword{internal}
