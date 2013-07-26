\name{AddFinalize}
\alias{AddFinalize}

\title{
Function to add a finalize function to a \code{Topology}
}
\description{
\code{AddFinalize} is an auxiliary function for building up a \code{RStorm} topology. After initializing a \code{Topology} object the \code{AddFinalize} function can be used to add a final function, which receives as its parameter a list of all hashMaps stored during the stream. After running the stream \code{GetHashList} can be used to receive an object that is the same as the object received by the finalize function.
}
\arguments{
  \item{topology}{
	a \code{Topology} object to add the bolt to.
}
  \item{bolt}{
	a \code{Bolt} to add to as the finalize function. 
}
  \item{.verbose}{
	a logical indicator to state whether or not verbose output should be printed.
}
}

\value{
An object of type \code{Topology} which  is a list containing the following elements:
\item{spout}{the data.frame passed as a spout}
\item{bolts}{a list of bolts, see \code{Bolt}}
\item{finailze}{the finalize function to be used for the stream} 
The specified \code{Bolt} has now been added to the finalize function. See \code{\link{Topology}} for more info.
}

\author{
	Maurits Kaptein
}


\seealso{
	See Also: \code{\link{Topology}}, \code{\link{Bolt}}, \code{\link{RStorm}}
}
\examples{
	bolt1 <- function(x, ...){print(x)}
	topology <- Topology(data.frame(x=c(1:10)))
	topology <- AddFinalize(topology, Bolt(bolt1))
	topology
}
\keyword{ utilities }
\keyword{ programming }
