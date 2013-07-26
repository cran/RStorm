\name{GetTrack}
\alias{GetTrack}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to retrieve objects stored using the \code{SetTrack} functionality during a stream.
}
\description{
Within bolts in a RStorm stream the \code{TrackRow} function can be used to store the state of variables at that point during the stream. The \code{TrackRow} function will store values incrementally during the stream. Thus, \code{TrackRow} enables one to store a set of parameter at each event in a Bolt. The current \code{GetTrack} function allows for inspection of these stored values after running the Stream by passing the RStorm result object.
}
\usage{
GetTrack(name, x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{name}{
	a string with the name of the tracked parameter values. Name corresponds to the name used in the call to the \code{TrackRow} function during the stream.
}
  \item{x}{
	a RStorm result object.
}
}

\value{
	a data.frame containing the parameters that are tracked at each iteration of a bolt.
}

\author{
Maurits Kaptein
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
	See Also: \code{\link{TrackRow}}, \code{\link{SetHash}}, \code{\link{GetHash}}, \code{\link{GetTrackNames}}
}
\examples{

# Create a topology with a spout
topology <- Topology(data.frame(x=c(1:10)))

# Add a bolt to the topology
computeSum <- function(x, ...){
	sum <- GetHash("sum")
	if(is.data.frame(sum)){
		x <- sum + (x[1])
	}
	SetHash("sum", x)
	# Track the current state during the stream:
	TrackRow("sum", data.frame(x=x))
}
topology <- AddBolt(topology, Bolt(computeSum))

# Run the stream
result <- RStorm(topology)

# Inspect the sums during the stream
GetTrack("sum", result)

}

\keyword{ utilities }
\keyword{ programming }
