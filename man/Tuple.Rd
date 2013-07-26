\name{Tuple}
\alias{Tuple}
\alias{is.Tuple}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create an object of type \code{Tuple} to emit down a stream.
}
\description{
A \code{Tuple} is the main data object that is passed around in a stream. The spout emits Tuples to the different Bolts, and Bolts can Emit Tuples to one another depending on the Topology. The \code{Emit} function checks whether indeed objects of type \code{Tuple} are emitted. A \code{Tuple} object is a single row data.frame.
}
\usage{
Tuple(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
	a single row data.frame
}
  \item{\dots}{
	any other argument
}
}

\value{
	an object of type \code{Tuple} to be used by an RStorm emitter function
}

\section{Additional Info}{The \code{is.Tuple} function checks whether an object is of Type Tuple and is used internally.}

\author{
Maurits Kaptein
}

\seealso{
\code{\link{Emit}}, \code{\link{Topology}}, \code{\link{RStorm}}
}
\examples{

# Example of a simple object emitted down a stream
spout <- data.frame(x=seq(1,4))
topology <- Topology(spout)

# The Emit function will check if the emitted object is indeed a Tuple
bolt.1 <- function(x, ...){
		Emit(Tuple(x), ...)
	}
	
bolt.2 <- function(x, ...){
	x <- as.numeric(x[1])
	print(x^2)
	}
	
topology <- AddBolt(topology, Bolt(bolt.1, listen=0))
topology <- AddBolt(topology, Bolt(bolt.1, listen=1))
topology <- AddBolt(topology, Bolt(bolt.2, listen=2))

result <- RStorm(topology)
#plot(topology)

}
\keyword{ utilities }
\keyword{ programming }
