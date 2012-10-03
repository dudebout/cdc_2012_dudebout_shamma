module StockMarket where

import Data.Ix (Ix)
import GTL.Data.Dynamic (DynamicXAS)
import GTL.Data.Utility (UtilityXAS)
import GTL.Data.Signaling (SignalingWXAS, SignalingWXAS2)
import GTL.Numeric.Probability (Trans, Dist, joint2)
import Numeric.Probability.Distribution (choose, certainly)

data Order = Sell | Hold | Buy deriving (Bounded, Eq, Ix, Ord, Show)
data Price = Low | High deriving (Bounded, Eq, Ix, Ord, Show)
data Market = Bear | Bull deriving (Bounded, Eq, Ix, Ord, Show)
data Portfolio = Zero | One | Two | Three | Four deriving (Bounded, Enum, Eq, Ix, Ord, Show)
type Environment = (Market, Price)
type State = (Portfolio, Price)

env :: Trans Market
env Bull = choose 0.20 Bear Bull
env Bear = choose 0.15 Bull Bear

mixing = 0.01

pric :: Price -> Market -> Order -> Dist Price
pric Low e u = choose lowToHigh High Low
    where lowToHigh = max ((1 - mixing) * up) mixing
          up          = (market e + order u) / 2
          market Bull = 1
          market Bear = 0
          order Buy   = 1
          order _     = 0
pric High e u = choose highToLow Low High
    where highToLow = max ((1 - mixing) * down) mixing
          down        = (market e + order u) / 2
          market Bull = 0
          market Bear = 1
          order Sell  = 1
          order _     = 0

pric2 :: Price -> Market -> (Order, Order) -> Dist Price
pric2 Low e (u1, u2) = choose lowToHigh High Low
    where lowToHigh = max ((1 - mixing) * up) mixing
          up          = (market e + order u1 + order u2) / 2
          market Bull = 1
          market Bear = 0
          order Buy   = 0.5
          order _     = 0
pric2 High e (u1, u2) = choose highToLow Low High
    where highToLow = max ((1 - mixing) * down) mixing
          down        = (market e + order u1 + order u2) / 2
          market Bull = 0
          market Bear = 1
          order Sell  = 0.5
          order _     = 0

sig :: SignalingWXAS Environment State Order Price
sig (e, p) _ u = do
  e' <- env e
  p' <- pric p e u
  return $ ((e', p'), p')

sig2 :: SignalingWXAS2 Environment State Order Price State Order Price
sig2 (e, p) _ u1 _ u2 = do
  e' <- env e
  p' <- pric2 p e (u1, u2)
  return $ ((e', p'), p', p')

dyn' :: DynamicXAS Portfolio Order Price
dyn' Zero Sell _ = certainly Zero
dyn' Four Buy  _ = certainly Four
dyn' x    Sell _ = certainly $ pred x
dyn' x    Hold _ = certainly x
dyn' x    Buy  _ = certainly $ succ x

dyn :: DynamicXAS State Order Price
dyn = dynamicWithSignalInState dyn'

util' :: UtilityXAS Portfolio Order Price
util' Zero Sell _      = -1
util' Four Buy  _      = -1
util' _    Hold _      = 0
util' _    Sell Low    = 1
util' _    Sell High   = 2
util' _    Buy  Low    = -1
util' _    Buy  High   = -2

util :: UtilityXAS State Order Price
util = utilityWithSignalInState util'

dynamicWithSignalInState :: DynamicXAS x a s -> DynamicXAS (x, s) a s
dynamicWithSignalInState dyn (x, s) a s' = joint2 (dyn x a s) (certainly s')

utilityWithSignalInState :: UtilityXAS x a s -> UtilityXAS (x, s) a s
utilityWithSignalInState util (x, s) a _ = util x a s
