\name{AddBolt}
\alias{AddBolt}

\title{
Function to add a \code{Bolt} to a \code{Topology} object to specify a stream.
}
\description{
\code{AddBolt} is an auxiliary function for building up a \code{RStorm} topology. After initializing a \code{Topology} object the \code{AddBolt} function can be used to build the topology and specify the order of the Bolts. A \code{Bolt} receives as its first argument the \code{Tuple} emitted by the previous element in the Stream.
}
\usage{
AddBolt(topology, bolt, .verbose = TRUE)
}

\arguments{
  \item{topology}{
	a \code{Topology} object to add the bolt to.
}
  \item{bolt}{
	a \code{Bolt} to add to the topology. These are created using the \code{Bolt()} function.
}
  \item{.verbose}{
	a logical indicator to state whether or not verbose output should be printed. Default TRUE.
}
}

\value{
 	An object of type \code{Topology} which  is a list containing the following elements:
	\item{spout}{the data.frame passed as a spout}
	\item{bolts}{a list of bolts, see \code{Bolt}}
	\item{finailze}{the finalize function to be used for the stream} 
	The specified \code{Bolt} has now been added to the list of bolts. See \code{\link{Topology}} for more info.
}

\section{Warning }{
	Functions which get added to a Topology using the AddBolt functionality should always use the ... argument. This argument is used to facilitate the processing of the stream. See example below for a minimal functional example of a correctly specified bolt.
}

\author{
	Maurits Kaptein
}

\seealso{
	See Also: \code{\link{Topology}}, \code{\link{Bolt}}, \code{\link{RStorm}}
}

\examples{

# Create a topology and add a bolt to it.
bolt1 <- function(x, ...){print(x)}
topology <- Topology(data.frame(x=c(1:10)))
topology <- AddBolt(topology, Bolt(bolt1, listen=0))
topology

}


% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ utilities }
\keyword{ programming }
