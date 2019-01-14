## Hashmaps

# Although R does not provide a native hash table structure, similar functionality can be achieved by leveraging the
# fact that the environment object returned from new.env (by default) provides hashed key lookups. The following
# two statements are equivalent, as the hash parameter defaults to TRUE:

hash_map <- new.env(hash = TRUE)
hash_map <- new.env()

# Insertion of elements may be done using either of the '<-' or '$' methods:

hash_map[["key"]] = "value"
hash_map$key2 = "value2"

hash_map$key         # returns "value"
hash_map[["key2"]]   # returns "value2"

# Elements can be removed using rm:

rm("key", envir = hash_map)

ls.str(hash_map)     # returns key2 :  chr "value2"

# One of the major benefits of using environment objects as hash tables is their ability to store virtually any
# type of object as a value, even other environments:

hash_map2 <- new.env()
hash_map2[["a"]] <- LETTERS
hash_map2[["b"]] <- as.list(x = 1:5, y = matrix(rnorm(10), 2))
hash_map2[["c"]] <- head(mtcars, 3)
hash_map2[["d"]] <- Sys.Date()
hash_map2[["e"]] <- Sys.time()

