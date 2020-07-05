main = print "Hi"

data Machine =
  State
    { acc :: Int
    , mem :: [Int]
    , prog :: [Inst]
    , source :: [Inst]
    }

type Addr = Int

data Inst
  = Add Addr -- acc <- acc + M[Addr]
  | Sub Addr
  | Mul Addr
  | Div Addr
  | LDI Int -- acc <- Int
  | LDD Addr -- acc <- M[Addr]
  | LDN Addr -- acc <- M[M[Addr]]
  | STOR Addr -- M[Addr] <- acc
  | GOTO Addr
  | Beqz Addr -- if acc = 0 then GOTO Addr

next :: Machine -> Maybe Machine
next State {acc = acc, mem = mem, prog = [], source = source} = Nothing
next State {acc = acc, mem = mem, prog = (n:prog), source = source} =
  case n of
    Add a -> Just $ State (acc + a) mem prog source
    Sub a -> Just $ State (acc - a) mem prog source
    Mul a -> Just $ State (acc * a) mem prog source
    Div a -> Just $ State (div acc a) mem prog source
    LDI val -> Just $ State val mem prog source
    LDD addr -> Just $ State (mem !! addr) mem prog source
    LDN addr -> Just $ State (mem !! (mem !! addr)) mem prog source
    STOR addr -> Just $ State acc (set addr mem acc) prog source
    GOTO addr -> Just $ State acc mem (skip addr source) source
    Beqz addr ->
      Just $
      case addr of
        0 -> State acc mem (skip addr source) source
        _ -> State acc mem prog source

set :: Int -> [Int] -> Int -> [Int]
set index arr value = take (index - 1) arr ++ [value] ++ skip (index + 1) arr

skip 0 arr = arr
skip n (x:xs) = skip (n - 1) xs
