module Depreciation where

import Data.Time.Calendar (addGregorianMonthsClip)
import Hledger
import qualified Config

createTransactions :: Config.Config -> [ Transaction ]
createTransactions config = 
    let
        purchaseDate = read (Config.date config)
        periodCount = fromEnum $ Config.periods config
        fullAmount = amountp' (Config.amount config)
        -- We show and read to lose extra decimals
        periodAmount = amountp' $ showAmount $ divideAmount (toEnum periodCount) fullAmount
        restAmount = fullAmount - (multiplyAmount ((toEnum periodCount) - 1) periodAmount)
        describe d t = t { tdescription = d }
        purchaseTransaction = describe (Config.description config) $ transaction purchaseDate
            [ post (Config.assetAccount config) fullAmount
            , post "assets:manual" (multiplyAmount (-1) fullAmount)
            ]
        makeDepreciationTransaction d a = describe ("Depreciation for " <> Config.description config) $ transaction d
            [ post (Config.expenseAccount config) a
            , post (Config.assetAccount config) (multiplyAmount (-1) a)
            ]
        indexToDepreciationTransaction i =
            makeDepreciationTransaction (addGregorianMonthsClip i purchaseDate) (if i == 0 then restAmount else periodAmount)
        depreciations =
            indexToDepreciationTransaction <$> [ 0..(toEnum periodCount - 1) ]
    in
    purchaseTransaction : depreciations
