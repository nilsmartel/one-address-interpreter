{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_oneaddress_vm (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/nilsmartel/Development/haskell/address-1-machine/.stack-work/install/x86_64-osx/17ae0ceba698fb3b4029b5360ece6ee8460be11b1bff0afc0bec6de122a65575/8.8.3/bin"
libdir     = "/Users/nilsmartel/Development/haskell/address-1-machine/.stack-work/install/x86_64-osx/17ae0ceba698fb3b4029b5360ece6ee8460be11b1bff0afc0bec6de122a65575/8.8.3/lib/x86_64-osx-ghc-8.8.3/oneaddress-vm-0.1.0.0-KryJz8WfYqRBQjHpJLtTZc-oneaddress-vm-exe"
dynlibdir  = "/Users/nilsmartel/Development/haskell/address-1-machine/.stack-work/install/x86_64-osx/17ae0ceba698fb3b4029b5360ece6ee8460be11b1bff0afc0bec6de122a65575/8.8.3/lib/x86_64-osx-ghc-8.8.3"
datadir    = "/Users/nilsmartel/Development/haskell/address-1-machine/.stack-work/install/x86_64-osx/17ae0ceba698fb3b4029b5360ece6ee8460be11b1bff0afc0bec6de122a65575/8.8.3/share/x86_64-osx-ghc-8.8.3/oneaddress-vm-0.1.0.0"
libexecdir = "/Users/nilsmartel/Development/haskell/address-1-machine/.stack-work/install/x86_64-osx/17ae0ceba698fb3b4029b5360ece6ee8460be11b1bff0afc0bec6de122a65575/8.8.3/libexec/x86_64-osx-ghc-8.8.3/oneaddress-vm-0.1.0.0"
sysconfdir = "/Users/nilsmartel/Development/haskell/address-1-machine/.stack-work/install/x86_64-osx/17ae0ceba698fb3b4029b5360ece6ee8460be11b1bff0afc0bec6de122a65575/8.8.3/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "oneaddress_vm_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "oneaddress_vm_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "oneaddress_vm_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "oneaddress_vm_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "oneaddress_vm_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "oneaddress_vm_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
