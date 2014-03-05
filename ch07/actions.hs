--file: ch07/actions.hs

main :: IO ()
main = do
	str2action "Staring Program..."
	printall
	str2action "Done!"

str2action :: String -> IO ()
str2action input = putStrLn $ "Data: " ++ input

list2actions :: [String] -> [IO ()]
list2actions = map str2action

numbers :: [Int]
numbers = [0..10]

strings :: [String]
strings = map show numbers

actions :: [IO ()]
actions = list2actions strings

printall :: IO ()
printall = runall actions

runall :: [IO ()] -> IO ()
runall [] = return ()
runall (x:xs) = x >> runall xs
