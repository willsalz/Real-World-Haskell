-- file: ElfMagic.hs

import qualified Data.ByteString.Lazy as L
import System.FilePath

main :: IO ()
main = do
	path <- getLine :: IO System.FilePath.FilePath
	elf <- isElfFile path
	print elf

	mach <- isMachOFile path
	print mach

hasElfMagic :: L.ByteString -> Bool
hasElfMagic content = L.take 4 content == elfMagic
	where elfMagic = L.pack [0x7f, 0x45, 0x4c, 0x4]

hasMachOMagic :: L.ByteString -> Bool
hasMachOMagic content = L.take 4 content == machOMagic
	where machOMagic = L.pack [0xCF, 0xFA, 0xED, 0xFE]

isElfFile :: System.FilePath.FilePath -> IO Bool
isElfFile path = do
	content <- L.readFile path
	return (hasElfMagic content)

isMachOFile :: System.FilePath.FilePath -> IO Bool
isMachOFile path = do
	content <- L.readFile path
	return (hasMachOMagic content)
