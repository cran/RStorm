\name{GetTrackNames}
\alias{GetTrackNames}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to retrieve the names of all tracked objects using \code{SetTrack}
}
\description{
Within bolts in a RStorm stream the \code{TrackRow} function can be used to store the state of variables at that point during the stream. The \code{TrackRow} function will store values incrementally during the stream. Thus, \code{TrackRow} enables one to store a set of parameter at each event in a Bolt. The current \code{GetTrackNames} function allows to inspect all the tracked objects of a stream by passing the RStorm result object.
}
\usage{
GetTrackNames(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
	a RStorm result object.
}
}

\value{
	A list of names of the tracked objects during the stream.
}

\author{
Maurits Kaptein
}

\seealso{
See Also: \code{\link{TrackRow}}, \code{\link{SetHash}}, \code{\link{GetHash}}, \code{\link{GetTrack}}
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
	GetTrackNames(result)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ utilities }
\keyword{ programming }
