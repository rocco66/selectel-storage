module Example where

import Control.Monad.IO.Class (liftIO)

import Swift

import Selectel.Storage

main :: IO ()
main = let
    authentificator = SelcdnAuth { selcdnAuthAccount = "7091"
                                 , selcdnAuthKey     = "WZ17lHHu7O" }
    authUrl = "https://auth.selcdn.ru" in
    runSwift authUrl authentificator $ do
        -- headAccount >>= liftIO . putStrLn . show
        -- postAccount [ ("X-Account-Hswift", "testMeta")]
        -- headAccount >>= liftIO . putStrLn . show

        -- getContainer "hswift" >>= liftIO . putStrLn . show

        -- putContainer "hswift1"
        -- putContainer "hswift2"
        -- getAccount >>= liftIO . putStrLn . show
        putObject "1" "111" [] "0123"
