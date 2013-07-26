\name{ShowFinalize}
\alias{ShowFinalize}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to display the name of the finalize function.
}
\description{
Utility function to display the finalize function of a RStorm topology object or display the result of a finalize function of an RStorm result object.
}
\usage{
ShowFinalize(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
     a topology created using \code{Topology}
}
}

\value{
	prints the finalize function of a Topology object. 
}

\author{
Maurits Kaptein
}

\seealso{
See Also: \code{\link{Topology}}, \code{\link{RStorm}}, \code{\link{GetHash}}, 
}
\examples{

# Simple display of the finalize function itself
topology <- Topology(data.frame(x=c(1:10), y=rep(1,10)))

bolt.1 <- function(x, ...){ SetHash("finalize", data.frame(x=99)) }
topology <- AddBolt(topology, Bolt(bolt.1))

comp.av <- function(object, ...){ 
	return( rep(object$finalize$x, 10)) }

topology <- AddFinalize(topology, Bolt(comp.av))
ShowFinalize(topology)

# and in the result object:
result <- RStorm(topology)
ShowFinalize(result)


}

\keyword{ utilities }
\keyword{ programming }
