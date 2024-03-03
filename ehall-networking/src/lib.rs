#![allow(clippy::needless_return)]

// uniffi::include_scaffolding!("ehall-networking");
uniffi::setup_scaffolding!();

pub mod auth;
pub mod info;
pub mod score;

use auth::*;
use info::*;
use score::*;

const BACKEND_HOST: &str = "http://47.115.205.46:8080";

#[derive(uniffi::Object)]
pub enum REhallDataModel {
    NotLoggedIn,
    LoggedIn {
        username_and_password: RUsernameAndPassword,
        school: RSchcool,
        auth_token: RAuthToken,
    },
    Ok {
        username_and_password: RUsernameAndPassword,
        school: RSchcool,
        auth_token: RAuthToken,
        user_info: RUserInfo,
        user_score: Vec<RScore>,
    },
}

impl Default for REhallDataModel {
    fn default() -> Self {
        Self::new()
    }
}

#[uniffi::export]
impl REhallDataModel {

    #[uniffi::constructor]
    pub fn new() -> Self {
        Self::NotLoggedIn
    }

    pub async fn login(
        &self,
        username: String,
        password: String,
        school: RSchcool,
    ) -> Self {
        let username_and_password = RUsernameAndPassword { username, password };
        match login(&username_and_password, school).await {
            Ok(auth_token) => REhallDataModel::LoggedIn {
                username_and_password,
                school,
                auth_token,
            },
            Err(_e) => REhallDataModel::NotLoggedIn,
        }
    }

    // pub async fn get_user_info(&mut self) {}

    pub async fn logout(&self) -> Self {
        REhallDataModel::NotLoggedIn
    }
}

async fn login(
    username_and_password: &RUsernameAndPassword,
    school: RSchcool,
) -> Result<RAuthToken, Box<dyn std::error::Error>> {
    let url = format!("{}/{}/cas_login", BACKEND_HOST, school.as_str());
    let client = reqwest::Client::new();
    let response = client
        .post(&url)
        .json(&RLoginRequest::from(username_and_password))
        .send()
        .await?;
    let response = response.json::<RLoginResponse>().await?;
    response.auth_token.ok_or(response.message.into())
}

pub async fn request_user_info(
    auth_token: &RAuthToken,
    school: &RSchcool,
) -> Result<RUserInfo, Box<dyn std::error::Error>> {
    let url = format!("{}/{}/user/info", BACKEND_HOST, school.as_str());
    let client = reqwest::Client::new();
    let response = client
        .get(&url)
        .header("Authorization", auth_token)
        .send()
        .await?;
    let response = response.json::<RUserInfoResponse>().await?;
    response.data.ok_or(response.message.into())
}

pub async fn request_user_score(
    auth_token: &RAuthToken,
    school: &RSchcool,
) -> Result<Vec<RScore>, Box<dyn std::error::Error>> {
    let url = format!("{}/{}/user/score", BACKEND_HOST, school.as_str());
    let client = reqwest::Client::new();
    let response = client
        .get(&url)
        .header("Authorization", auth_token)
        .send()
        .await?;
    let response = response.json::<RScoreResponse>().await?;
    response.data.ok_or(response.message.into())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_login() {
        let x = RUsernameAndPassword::new("21220513".into(), "283511".into());
        let y = login(&x, RSchcool::NanjingNormalUniversity).await;
        assert!(y.is_ok());
    }
}

#[uniffi::export]
pub fn rust_add(left: u64, right: u64) -> u64 {
    left + right
}

#[uniffi::export]
pub fn rust_greeting(name: &str) -> String {
    format!("Hello, {}, this is rust!", name)
}
