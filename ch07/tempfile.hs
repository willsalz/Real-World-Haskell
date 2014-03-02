-- file ch07/tempfile.hs

import System.IO
import System.Directory(getTemporaryDirectory, removeFile)
import Control.Exception(catch)
import Control.Exception(finally)

-- The main entry point. Work with a temp file in myAction.
main :: IO ()
main = withTempFile "mytemp.txt" myAction


{- The guts of the program. Called with the path and handle of a temporary
file. When this function exits, that file will be closed and deleted
because myAction was called from withTempFile -}
myAction :: FilePath -> Handle -> IO ()
myAction tempname temph =
	do -- Start by displaying a greeting on the terminal
		putStrLn "Welcome to tempfile.hs"
		putStrLn $ "I have atemprary file at: " ++ tempname

		-- Let's see what the initial position is
		pos <- hTell temph
		putStrLn $ "My initial position is: " ++ show pos

		-- Now, write some data to the temporary file
		let tempdata = show [1..10]
		putStrLn $ "Writing on line containing " ++ show (length tempdata) ++ " bytes: " ++ tempdata
		hPutStrLn temph tempdata

		{- Get our new position. This doesn't actually modify pos
		in memory, but makes hte name "pos" correspond to a different
		value for the remainder of the "do" block. -}
		pos <- hTell temph
		putStrLn $ "After writing, my new position is " ++ show pos

		-- Seek o the beginning of the file and display it
		putStrLn $ "The file content is: "
		hSeek temph AbsoluteSeek 0

		-- hGetContents performs a lazy read and display
		c <- hGetContents temph
		putStrLn c

		putStrLn $ "Which could be expressed as this Haskell literal: "
		print c

withTempFile :: String -> (FilePath -> Handle -> IO a) -> IO a
withTempFile  pattern func =
	do
		tempdir <- catch (getTemporaryDirectory) (\_ -> return ".")
		(tempfile, temph) <- openTempFile tempdir pattern

		finally (func tempfile temph)
				(do hClose temph
					removeFile tempfile)

