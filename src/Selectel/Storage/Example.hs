{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Selectel.Storage.Example (test) where

import Control.Monad.IO.Class (liftIO)
import Data.ByteString (ByteString)

import Swift

data SelcdnAuth = SelcdnAuth
    { selcdnAuthAccount :: ByteString
    , selcdnAuthKey     :: ByteString
    } deriving (Show, Eq)

data SwiftConnectInfo = SwiftConnectInfo
    { swiftConnectInfoStorageUrl :: {-# UNPACK #-} !ByteString
    , swiftConnectToken          :: {-# UNPACK #-} !ByteString }
  deriving (Eq, Show)

instance SwiftAuthenticator SelcdnAuth SwiftConnectInfo where
    mkRequestAuthInfo SelcdnAuth { .. } =
        addHeaders [ ("X-Auth-User", selcdnAuthAccount)
                   , ("X-Auth-Key", selcdnAuthKey) ]
    getStorageUrl = swiftConnectInfoStorageUrl
    prepareRequest SwiftConnectInfo { .. } =
        addHeader ("X-Auth-Token", swiftConnectToken)
    mkInfoState resp = do
        swiftConnectInfoStorageUrl <- findHeaderInResponse resp "X-Storage-Url"
        swiftConnectToken <- findHeaderInResponse resp "X-Storage-Token"
        return SwiftConnectInfo { .. }

test :: IO ()
test = let
    authentificator = SelcdnAuth { selcdnAuthAccount = ""
                                 , selcdnAuthKey     = "" }
    -- authUrl = "https://auth.selcdn.ru" in
    authUrl = "https://auth.selcdn.ru" in
    runSwift authUrl authentificator $
        getContainer "hswift" >>= liftIO . putStrLn . show
