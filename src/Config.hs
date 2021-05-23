{-# LANGUAGE DeriveGeneric #-}

module Config where

import Dhall
import Hledger

data Config =
  Config 
    { date :: String
    , description :: Text
    , amount :: String
    , assetAccount :: Text
    , expenseAccount :: Text
    , periods :: Natural
    }
    deriving (Generic, Show)

instance FromDhall Config
