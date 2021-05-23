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

main :: IO ()
main = do
    -- configFile <- head <$> getArgs
    let configFile = "test.dhall"

    config <- inputFile auto configFile

    errLn ("Generating depreciations for '" <> Config.description config <> "'...")

    let transactions = Depreciation.createTransactions config
    mapM (putStrLn . showTransaction) transactions

    errLn "Done!"
