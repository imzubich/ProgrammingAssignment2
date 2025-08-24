### makeCacheMatrix creates a special "matrix" object 
## that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL   # Inverse ko store karne ke liye placeholder
  
  # set function (nayi matrix set karega)
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  # get function (matrix ko return karega)
  get <- function() x
  
  # setInverse function (inverse ko store karega)
  setInverse <- function(inverse) inv <<- inverse
  
  # getInverse function (cached inverse ko return karega)
  getInverse <- function() inv
  
  # List return karna (object jaisa behave karega)
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}

## cacheSolve computes the inverse of the special "matrix"
## returned by makeCacheMatrix. If the inverse has already
## been calculated (and the matrix has not changed),
## then it should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
  inv <- x$getInverse()
  
  # Agar cache me inverse already hai to wahi return kar do
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  
  # Agar cache me nahi hai to naya calculate karo
  data <- x$get()
  inv <- solve(data, ...)   # inverse calculate karna
  x$setInverse(inv)         # cache me store karna
  inv
}
