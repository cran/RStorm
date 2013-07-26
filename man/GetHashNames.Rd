\name{GetHashNames}
\alias{GetHashNames}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to retrieve the names of locally stored objects in the stream.}
\description{
Function retrieves from an RStorm result object (after running a stream) all the names of all items stored in during the stream (using \code{SetHash}) as a list.
}
\usage{
GetHashNames(object)
}
%- maybe also 'usage' for other objects documented here.
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{
	a \code{RStorm} result object
}
}

\value{
	a list containing all names stored using \code{SetHash} during a stream.
}

\author{
	Maurits Kaptein
}


%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
	See Also: \code{\link{SetHash}}, \code{\link{GetHash}}, \code{\link{GetHashNames}}
}
\examples{

	# Create a topology
	topology <- Topology(data.frame(x=rnorm(100,0,1)))

	# Create two bolts and add them to the topology
	computeSum <- function(x, ...){
		sum <- GetHash("sum")
		if(is.data.frame(sum)){
			x <- sum + (x[1])
		}
		SetHash("sum", x)
	}
	computeSumSquared <- function(x, ...){
		sum2 <- GetHash("sum2")
		if(is.data.frame(sum2)){
			x <- sum2 + (x[1]^2)
		}
		SetHash("sum2", x)
	}
	topology <- AddBolt(topology, Bolt(computeSum))
	topology <- AddBolt(topology, Bolt(computeSumSquared))

	# Run the stream
	result <- RStorm(topology)

	# Get the names of all the stored objects during the stream
	print(GetHashNames(result))


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ utilities }
\keyword{ programming }