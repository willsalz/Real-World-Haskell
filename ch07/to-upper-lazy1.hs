import System.IO(openFile, hGetContents, hPutStr, hClose)
import System.IO(IOMode(ReadMode,WriteMode))
import Data.Char(toUpper)

main :: IO ()
main = do
    inh <- openFile "input.txt" ReadMode
    outh <- openFile "output.txt" WriteMode
    inStr <- hGetContents inh
    let result = processData inStr
    hPutStr outh result
    hClose inh
    hClose outh

processData :: String -> String
processData = map toUpper
