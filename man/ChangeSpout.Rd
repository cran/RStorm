\name{ChangeSpout}
\alias{ChangeSpout}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to change the Spout of a Topology
}

\description{
The \code{ChangeSpout} function is used to change the spout of an topology that was already defined. It can be used (e.g) for the simulation of a data stream process on multiple data-sets.
}

\usage{
ChangeSpout(topology, spout)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{topology}{
	a RStorm Topology object.
}
  \item{spout}{
	a new spout. E.g., a new code{data.frame}.
}
}

\value{
An object of class \code{Topology} which is a list containing the following elements:
	\item{spout}{the data.frame passed as a spout}
	\item{bolts}{a list of bolts, see \code{Bolt}}
	\item{finailze}{the finalize function to be used for the stream}
}

\section{Warning }{
	Functions used as bolt in a stream should always use the dots argument (...) to facilitate the internal working of \code{RStorm}.
}

\section{Additional Info}{The \code{is.Bolt} function checks whether an object is of Type Bolt and is used internally.}

\author{
	Maurits Kaptein
}

\seealso{
	See Also: \code{\link{Topology}}, \code{\link{AddBolt}}, \code{\link{RStorm}}
}
\examples{

# create a data set.
x <- seq(1, 100)
topology <- Topology(data.frame(x=x))

# Setup a simple topology to compute a sum
computeSum <- function(x, ...){
	sum <- GetHash("sum")
	if(is.data.frame(sum)){
		x <- sum + (x[1])
	}
	SetHash("sum", x)
}

# Run the stream
topology <- AddBolt(topology, Bolt(computeSum))
result <- RStorm(topology)
print(GetHash("sum", result))

# Create an alternative dataset
x2 <- seq(2, 100)

# Change the dataset in the existing topology
topology <- ChangeSpout(topology, data.frame(x=x2))

# Run the new dataset
result <- RStorm(topology)
print(GetHash("sum", result))

}

\keyword{ utilities }
\keyword{ programming }
