\name{Bolt}
\alias{Bolt}
\alias{is.Bolt}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create a \code{Bolt} object to add to a stream
}
\description{
Function to create a \code{Bolt} object. A \code{Bolt} object consists of a function which receives as its first argument the \code{Tuple} emitted by the element the \code{Bolt} listens to.
}
\usage{
Bolt(FUNC, listen = 0, boltID = 0)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{FUNC}{
	a \code{[R]} function with a first argument which receive a \code{Tuple} and using the ,... specification to receive arguments auxiliary to the functioning of the stream.
}
  \item{listen}{
	a number indicating which element in the topology to listen too. $0$ indicates the Spout itself, while other integers refer to the Tuples emitted by other Bolts along the Stream. Default is $0$. Printing the Topology allows one to see the position number of each Bolt.
}
  \item{boltID}{
	(optional) the ID of this bolt. A given name -- mostly a number -- to pass the name of the bolt to the bolt itself which can be used to create (e.g.) a hashMap that is distinct for the current bolt.
}
}

\value{
An object of type \code{Bolt} which is a list containing the following elements:
\item{name}{the name of the function that was passed when initializing the Bolt}
\item{func}{the function itself}
\item{listen}{the identifier of the element in the stream from which the Bolt receives its Tuples} 
\item{id}{the id of the current Bolt} 
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

# Create a Bolt:
bolt1 <- function(x, ...){print(x)}
Bolt(bolt1, listen=0, boltID=12)

}

\keyword{ utilities }
\keyword{ programming }
