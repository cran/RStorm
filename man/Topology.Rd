\name{Topology}
\alias{Topology}
\alias{is.Topology}
\alias{print.Topology}
\alias{plot.Topology}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to create a topology
}
\description{
By passing a spout (dataframe) to this function and storing its return object you can start building a topology for a RStorm stream. See code{\link{RStorm}} for more detailed examples of the use of Topology. The Topology is the most important concept when defining a RStorm stream.
}
\usage{
Topology(spout, name = NULL, .verbose = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{spout}{
	 a data.frame containing multiple rows of data which are to be iterated through in the stream.
}
  \item{name}{
     an optional name of this topology. 
}
  \item{.verbose}{
     an optional boolean to indicate whether you want verbose output or not. Default is TRUE
}
}

\value{
An object of class \code{Topology} which is a list containing the following elements:
	\item{spout}{the data.frame passed as a spout}
	\item{bolts}{a list of bolts, see \code{Bolt}}
	\item{finailze}{the finalize function to be used for the stream}
}

\section{Additional Info}{The \code{is.Topology} function checks whether an object is of Type Topology and is used internally.}

\author{
Maurits Kaptein
}
\note{
For examples see www.mauritskaptein.com/software/RStorm
}

\seealso{
\code{\link{Bolt}}, \code{\link{Tuple}}, \code{\link{RStorm}}
}
\examples{


	##############################
	# Example of a stream to compare two methods of streaming variance computation:
	##############################

	# Generate some data 
	set.seed(10)
	t <- 100
	x <- rnorm(t,0,1)
	# Look at the variance as computed by var():
	var(x)

	# Start a topology
	topology <- Topology(data.frame(x=x))

	# Bolt for "Sum of Squares Method" with tracking over time
	var.SS <- function(x, ...){
		params <- GetHash("params1")
		if(!is.data.frame(params)){
			params <- list()
			params$n <- params$sum <- params$sum2 <- 0
		}
		n <- params$n + 1
		sum <- params$sum + as.numeric(x[1])
		sum2 <- params$sum2 + as.numeric(x[1]^2)
		if(n>1){
			var <- 1/(n*(n-1)) * (n*sum2 - sum^2)
		} else {
			var <- 0
		}
		SetHash("params1", data.frame(n=n, sum=sum, sum2=sum2, var=var))
		TrackRow("var.SS", data.frame(var=var))
	}


	## Bolt for "Welford's" Method:

	var.Welford <- function(x, ...){
		x <- as.numeric(x[1])
		params <- GetHash("params2")
		if(!is.data.frame(params)){
			params <- list()
			params$M <- x
			params$S <- params$n <- 0
		}
		n <- params$n + 1
		M <- params$M + ( x - params$M) / n
		S <- params$S + (x - params$M)*(x-M)

		if(n>1){
			var <- S / (n-1)
		} else {
			var <- 0
		}
		SetHash("params2", data.frame(n=n, M=M, S=S, var=var))
		TrackRow("var.Welford", data.frame(var=var))
	}

	# Add both topologies to a Stream:
	topology <- AddBolt(topology, Bolt(var.SS))
	topology <- AddBolt(topology, Bolt(var.Welford))
	result <- RStorm(topology)

	# Plot the results over the stream
	plot(c(1:t), GetTrack("var.Welford", result)$var, type="l")
	lines(c(1:t), GetTrack("var.SS", result)$var, col="red")


	# Now the same variance calculation, 
	#    but with a dataset in which the mean is 
	#    very large compared to the variance:
	x2 <- rnorm(t,10^8,1)
	topology2 <- Topology(data.frame(x=x2))
	topology2 <- AddBolt(topology2, Bolt(var.SS))
	topology2 <- AddBolt(topology2, Bolt(var.Welford))
	result2 <- RStorm(topology2)

	# This time the standard SS methods screws up (mind the different y scale):
	# (And mind the fact that the SS method gives NEGATIVE variance)
	plot(c(1:t), GetTrack("var.Welford", result2)$var, type="l", ylim=c(-10, 11))
	lines(c(1:t), GetTrack("var.SS", result2)$var, col="red")


}

\keyword{ utilities }
\keyword{ programming }
