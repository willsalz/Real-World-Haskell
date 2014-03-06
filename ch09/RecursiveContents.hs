-- file: RecursiveContents.hs

module RecursiveContents (getRecursiveContents) where

import Control.Monad (forM)
import System.Directory (doesDirectoryExist, getDirectoryContents)
import System.FilePath ((</>))


main :: IO ()
main = return ()

getRecursiveContents :: FilePath -> IO [FilePath]
getRecursiveContents topdir = do
	names <- getDirectoryContents topdir
	let propernames = filter (`notElem` [".",".."]) names
	paths <- forM propernames $ \name -> do
		let path = topdir </> name
		isDirectory <- doesDirectoryExist path
		if isDirectory
			then getRecursiveContents path
			else return [path]
	return (concat paths)
