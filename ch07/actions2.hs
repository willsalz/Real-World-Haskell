-- file: ch07/actions2.hs

str2message :: String -> String
str2message input = "Data: " ++ input

str2action :: String -> IO ()
str2action = putStrLn . str2message

numbers :: [Int]
numbers = [0..10]

main :: IO ()
main = do
	str2action "Starting Program..."
	mapM_ (str2action . show) numbers
	str2action "Done!"
