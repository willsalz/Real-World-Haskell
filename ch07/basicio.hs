-- file ch07/basicio.hs

main :: IO ()
main = do
	putStrLn "Greetings! What is your name?: "
	str <- getLine
	putStrLn $ "Welcome to Haskell, " ++ str ++ "!"
