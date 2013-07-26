\name{Emit}
\alias{Emit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to emit a \code{Tuple} along the stream. The emitted data \code{x} should be a single row of a \code{data.frame}.
}
\description{
Function to emit a \code{Tuple} along the stream. The emitted data \code{x} should be a single row of a \code{data.frame}. Tuples are the main data format passed around in an \code{RStorm} stream, and each emitted object is checked by the \code{Emit} function to be of class \code{Tuple}. 
}
\usage{
Emit(x, .name = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
	a \code{Tuple}. The only arguments that needs to be provided by the user.
}
  \item{.name}{
	(internal) the name of the emitter. Used internally.
}
  \item{\dots}{
	Additional arguments.
}
}

\value{
	TRUE. The \code{Emit} function does not return anything but rather adds the emitted Tuple to the internal list of emitted objects to be used by Spouts listening to the \code{Spout} or \code{Bolt} from which the data is emitted. The \dots argument always needs to be passed in a call to \code{Emit()} since it facilitates the internal working of the RStorm.
}

\author{
Maurits Kaptein
}

\seealso{
	See Also: \code{\link{Topology}}, \code{\link{AddBolt}}, \code{\link{RStorm}}
}
\examples{
	# This example can only be run within a Stream.
	# If run outside the Steam the Emit function will issue an error.
	\dontrun{
		x <- data.frame(var1 = c("test", "test2"), var2 = c(2,5))
		Emit(Tuple(x[1,]), ...)
	}
}

\keyword{ utilities }
\keyword{ programming }

