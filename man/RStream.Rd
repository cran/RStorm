\name{RStorm}
\alias{RStorm}
\alias{is.RStorm}
\alias{print.RStorm}
\alias{plot.RStorm}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Main function to run a stream.
}
\description{
\code{RStorm} provides the main functionality of the RStorm package. The \code{RStorm} function is used to run a stream defined using a Topology. The Topology defines the spout (the data-source for the stream) and the order of processing units (bolts). See example below and in the main package description for examples of the usage of \code{RStorm}.

More details of the package, examples of streaming algorithms, and examples of the use of RStorm can be found at http://software.mauritskaptein.com/RStorm
}
\usage{
RStorm(topology, .verbose = TRUE, .debug = FALSE, .batches = 100, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{topology}{
	a topology object specified using \code{Topology}. The topology contains all the necessary information (the definition of the spouts, the bolts, and the order of processing) for the stream to run in full.
}
  \item{.verbose}{
	a logical indicator for verbose output. Default is TRUE.
}
  \item{.debug}{
	a logical indicator for debug mode. If in debug mode all objects stored during the running of the stream will persist in memory and can be accessed using standard calls to \code{ls()}. Default is FALSE.
}
  \item{.batches}{
	a number. Determines the size of batches processed by a stream. While RStorm simulates streaming processing, in actuality the rows of the data.frame defined in the spout are iterated through in batches to prevent memory overflow when the spout contains a large number of rows. This argument sets the size of these batches and with it limits the size of memory allocated to emitted data during the stream. Default batch size is 100.
}
  \item{\dots}{additional arguments to pass to (e.g.) bolts or plotting functions.}
}


\value{
An object of type \code{RStorm} which is a list containing the following elements:
\item{data}{a list containing all the hashmaps stored during the stream using \code{SetHash}. Can be accessed by passing the result object to \code{GetHash}.}
\item{track}{a list containing all the data.frames stored using the \code{TrackRow} functionality. Can be accessed by passing the result object of an RStorm to \code{GetTrack}.}
\item{finalize}{the result of the finalize function. If a finalize function is added to the Topology this field will contain whatever was returned by the finalize function and can be accessed directly using \code{ShowFinalize}. If no finalize function was added to the topology or the finalize function does not return anything the value of finalize will be false} 
}

\section{Additional Info}{The \code{is.RStorm} function checks whether an object is of Type RStorm and is used internally.}

\references{
http://software.mauritskaptein.com/RStorm
}

\author{
Maurits Kaptein
}



\seealso{
See Also: \code{\link{Topology}}, \code{\link{Bolt}}, \code{\link{Tuple}}, \code{\link{Emit}}, \code{\link{TrackRow}}, \code{\link{SetHash}}, \code{\link{GetHash}}, \code{\link{GetTrack}}
}

\examples{

	# Run a simple RStorm. First, create some data:
	x <- seq(1, 1000)

	# Second, we start defining the topology
	topology <- Topology(data.frame(x=x))

	# Third, we define a bolt. 
	# This bolt computes the sum of a number stored 
	#   in a local Hashmap and the Tuple (x) that is received
	computeSum <- function(x, boltID, ...){
		sum <- GetHash(paste("sum", boltID))
		if(is.data.frame(sum)){
			x <- sum + (x[1])
		}
		SetHash(paste("sum", boltID), x)
		Emit(Tuple(x=x), ...)
	}

	# Add the bolts to the topology. 
	# Here the first bolt computes the sum of the sequence
	#   and the second bolt computes the sum of summed elements
	topology <- AddBolt(topology, Bolt(computeSum, listen=0, boltID=1))
	topology <- AddBolt(topology, Bolt(computeSum, listen=1, boltID=2))
	result <- RStorm(topology)
	print(GetHash("sum 1", result))
	print(GetHash("sum 2", result))
}

\keyword{ utilities }
\keyword{ programming }
