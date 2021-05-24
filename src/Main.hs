module Main where

import System.Environment (getArgs)
import Hledger
import Data.Time.Calendar
import Control.Error
import Dhall
import Config
import Depreciation
import Control.Monad
import qualified Data.Text as T
import qualified Data.Text.IO as T

main :: IO ()
main = do
    configFile <- head <$> getArgs

    config <- inputFile auto configFile

    err ("Generating depreciations for '" <> T.pack (Config.date config) <> " " <> Config.description config <> "' ... ")

    let transactions = Depreciation.createTransactions config
    mapM (T.putStrLn . showTransaction) transactions

    errLn "Done!"
