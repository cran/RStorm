\name{TrackRow}
\alias{TrackRow}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to store the value of some object in the stream over time.
}
\description{
Within bolts in a RStorm stream the \code{TrackRow} function can be used to store the state of variables at that point during the stream. The \code{TrackRow} function will store values incrementally during the stream. Thus, \code{TrackRow} enables one to store a set of parameter at each event in a Bolt. 
}
\usage{
TrackRow(name, row)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{name}{
	a string with the name of the object that is stored.
}
  \item{row}{
	a single row data.frame containing the parameters that are supposed to be tracked over time. See example.
}
}

\value{
 	TRUE if the row is correctly stored.
}

\author{
Maurits Kaptein
}

\seealso{
\code{\link{Topology}}, \code{\link{GetTrack}}, \code{\link{GetTrackNames}}
}
\examples{

# Create a topology with a simple spout
topology <- Topology(data.frame(x=c(1:10)))

# Define the bolt and add it 
computeSum <- function(x, ...){
	sum <- GetHash("sum")
	if(is.data.frame(sum)){
		x <- sum + (x[1])
	}
	SetHash("sum", x)
	TrackRow("sum", data.frame(x=x))
}
topology <- AddBolt(topology, Bolt(computeSum))

# Run the stream
result <- RStorm(topology)

# Insepct the result over the timepoints in the stream
GetTrack("sum", result)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ utilities }
\keyword{ programming }
