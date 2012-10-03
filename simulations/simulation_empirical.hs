import StockMarket

import Data.Tuple.Curry (uncurryN)
import GTL.Data.Mockup (Mockup, Role(..), mockupToArray, arrayToMockup)
import GTL.Data.History.Instances (History0)
import GTL.Numeric.Probability ((?!))
import Numeric.Probability.Distribution hiding (pretty, map)
import System.Random (mkStdGen)
import Control.Monad (replicateM_)
import Text.Printf (printf)

import GTL.Interaction.SimulatedLearning2 (Comp, Param(..), Var(..), runComp, logVar, oneStep, invProp)

initMock1 :: Mockup Order Price History0 History0
initMock1 = const $ choose 1 High Low

initMock2 :: Mockup Order Price History0 History0
initMock2 = const $ choose 0 High Low


tMax :: Int
tMax = 100

comp :: Comp Environment State Order Price History0 History0 State Order Price History0 History0 ()
comp = logVar >> oneStep

main :: IO ()
main = putStr $ concat $ ["time  phigh1   phigh2\n"] ++ (map (uncurryN $ printf "%5d %.6f %.6f\n") $ zip3 ([0..] :: [Int]) ps1 ps2 :: [String])
    where vals = runComp (replicateM_ (tMax + 1) comp) p v
          ps1 = map pHigh1 vals
          ps2 = map pHigh2 vals
          pHigh arr = arrayToMockup arr minBound ?! High
          pHigh1 = pHigh . mockupArray1
          pHigh2 = pHigh . mockupArray2
          arr1 = mockupToArray initMock1
          arr2 = mockupToArray initMock2
          epsi = 0
          rol = Role dyn util 0.95
          p = Param rol rol sig2 epsi epsi invProp invProp 1
          v = Var arr1 arr2 (mkStdGen 3) 1
