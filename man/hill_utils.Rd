% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gtoxHillACXX.R, R/gtoxHillConc.R,
%   R/gtoxHillVal.R, R/hill_utils.R
\name{gtoxHillACXX}
\alias{gtoxHillACXX}
\alias{gtoxHillConc}
\alias{gtoxHillVal}
\alias{Hill model utilites}
\title{Functions to solve the Hill model}
\usage{
gtoxHillACXX(XX, tp, ga, gw, bt = 0)

gtoxHillConc(val, tp, ga, gw, bt = 0)

gtoxHillVal(logc, tp, ga, gw, bt = 0)
}
\arguments{
\item{XX}{Numeric, the activity level (percentage of the top value)}

\item{tp}{Numeric, the top value from the Hill model}

\item{ga}{Numeric, the logAC50 value from the Hill model}

\item{gw}{Numeric, the Hill coefficient from the Hill model}

\item{bt}{Numierc, the bottom value from the Hill model}

\item{val}{Numeric, the activity value}

\item{logc}{Numeric, the log concentration}
}
\value{
None
}
\description{
These functions solve for Hill model parameters.
}
\details{
\code{gtoxHillVal} computes the value of the Hill model for a given log 
concentration. 

\code{gtoxHillACXX} computes the activity concentration for a Hill model for 
a given activity level.

\code{gtoxHillConc} computes the Hill model concentration for a 
given value.
}
\examples{
## The following code gives examples for a Hill model with a top of 50, 
## bottom of 0, AC50 of 1 and Hill coefficient of 1.
## gtoxHillVal calculates activity value given a concentration. gtoxHillVal
## will return the tp/2 when logc equals ga:
gtoxHillVal(logc = 1, tp = 50, ga = 1, gw = 1, bt = 0)

## Here, gtoxHillConc returns the concentration where the value equals 20
gtoxHillConc(val = 20, tp = 50, ga = 1, gw = 1, bt = 0)

## Note how this differs from gtoxHillACXX:
gtoxHillACXX(XX = 20, tp = 50, ga = 1, gw = 1, bt = 0)

## gtoxHillACXX is based on the top value and allows the user to calculate 
## specifc activity concentrations based on a percentage of the top value

## For example, we can calculate the value for the concentration 0.25, then
## use that value to check the other two functions.

value <- gtoxHillVal(logc = 0.25, tp = 50, ga = 1, gw = 1, bt = 0)
c1 <- gtoxHillConc(val = value, tp = 50, ga = 1, gw = 1, bt = 0)
c2 <- gtoxHillACXX(XX = value/50*100, tp = 50, ga = 1, gw = 1, bt = 0)
all.equal(0.25, c1, c2)

## Notice, the value had to be transformed to a percentage of the top value
## when using gtoxHillACXX

}
