--file: ch08/SumFile.hs

main :: IO ()
main = do
	contents <- getContents
	print (sumFile contents)
  where sumFile = sum . map read . words
