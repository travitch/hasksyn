{-# LANGUAGE CPP, ExistentialQuantification, KindSignatures, TypeFamilies #-}
module Test1 (
  -- * Types
  Type1,
  TF(..),
  -- * Functions
  func
  ) where

-- A normal comment
import Prelude hiding ( catch )
import qualified Control.Exception as E

-- | With some haddock
data Type1 a = TC1 a Int
             | TC2 [Double]
             -- ^ A special constructor
             | TC3
             deriving (Eq, Ord)

#if defined(__GLASGOW_HASKELL__)
class TF a where
  data Bar :: * -> *
  data Baz :: *

  tf :: Int -> Bar
#endif


func :: (Ord a, Eq a)
     => Int
     -> a
     -> IO (Type1 a)
func i a = do
  l <- getLine
  case l of
    'x' : _ -> return TC3
    _ -> do
      putStrLn "No 'x', but have a string pretending to let bindings"
      let foo = 100
          bar = 10 {- behave around ugly comments
          FIXME: With fixme highlighting
      return
      -}

      return$ TC1 a i *
        foo

