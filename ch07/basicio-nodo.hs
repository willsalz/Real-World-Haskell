-- file: ch07/basicio-nodo.hs

main :: IO ()
main = 	putStrLn "Greetings! What is your name?: " >>
		getLine >>=
		(\x -> putStrLn ( "Welcome to Haskell, " ++ x ++ "!") )
