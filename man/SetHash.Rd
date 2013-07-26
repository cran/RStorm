\name{SetHash}
\alias{SetHash}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to store a \code{data.frame} during a stream.
}
\description{
Within bolts in used in a RStorm the \code{GetHash} and \code{SetHash} functions can be used to access a local store (or hashmap) during the stream. This corresponds to the ability of tracking parameters over the stream using a hashmap or database system as implemented in production streaming software. 
}
\usage{
SetHash(name, data, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{name}{
	a string containing the name of the stored object
}
  \item{data}{
	a data.frame (or scalar) to be stored 
}
  \item{\dots}{
%%     ~~Describe \code{\dots} here~~
}
}

\value{
	If storing the value is successful returns TRUE.
}

\author{
Maurits Kaptein
}


\seealso{
See Also: \code{\link{TrackRow}}, \code{\link{SetHash}}, \code{\link{GetHash}}, \code{\link{GetTrack}}
}
\examples{

topology <- Topology(data.frame(x=rnorm(100,0,1)))
computeSum <- function(x, ...){
	sum <- GetHash("sum")
	if(is.data.frame(sum)){
		x <- sum + (x[1])
	}
	SetHash("sum", x)
}
topology <- AddBolt(topology, Bolt(computeSum))
result <- RStorm(topology)
print(GetHash("sum", result))


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ utilities }
\keyword{ programming }