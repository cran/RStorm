\name{GetHash}
\alias{GetHash}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to retrieve objects stored locally during the running of the stream.
}
\description{
Within bolts in used in a RStorm the \code{GetHash} and \code{SetHash} functions can be used to access a local store (or hashmap) during the stream. This corresponds to the ability of tracking parameters over the stream using a hashmap or database system as implemented in production streaming software. The function is overloaded to retrieve the state of the hashmap at the end of a stream from an RStorm result object. See the examples for the two usages.
}
\usage{
GetHash(name, object = NULL)
}

\arguments{
  \item{name}{
	a string containing the name of the hashmap that is accessed from within the Stream.
}
  \item{object}{
	(optional) the RStorm result object. If used outside of a bolt in a stream the result object needs to be passed in which the end-state of the hashmaps created in the stream are stored.
}
}

\value{
	a dataframe containing whatever was set using the SetHash function.
}

\author{
Maurits Kaptein
}

\seealso{
	See Also: \code{\link{SetHash}}, \code{\link{GetHashList}}, \code{\link{GetHashNames}}
}
\examples{

# Create a topology with a spout:
topology <- Topology(data.frame(x=rnorm(100,0,1)))

# declare a bolt and add it to the topology
computeSum <- function(x, ...){
	sum <- GetHash("sum")  # get from local store
	if(is.data.frame(sum)){
		x <- sum + (x[1])
	}
	SetHash("sum", x)  # add to local store
}
topology <- AddBolt(topology, Bolt(computeSum))

# run the stream
result <- RStorm(topology)

# access the local store
print(GetHash("sum", result))

}

\keyword{ utilities }
\keyword{ programming }
