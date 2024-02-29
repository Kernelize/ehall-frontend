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
pub enum EhallDataModel {
    NotLoggedIn,
    LoggedIn {
        username_and_password: UsernameAndPassword,
        school: Schcool,
        auth_token: AuthToken,
    },
    Ok {
        username_and_password: UsernameAndPassword,
        school: Schcool,
        auth_token: AuthToken,
        user_info: RUserInfo,
        user_score: Vec<Score>,
    },
}

impl Default for EhallDataModel {
    fn default() -> Self {
        Self::new()
    }
}

#[uniffi::export]
impl EhallDataModel {

    #[uniffi::constructor]
    pub fn new() -> Self {
        Self::NotLoggedIn
    }

    pub async fn login(
        &self,
        username: String,
        password: String,
        school: Schcool,
    ) -> Self {
        let username_and_password = UsernameAndPassword { username, password };
        match login(&username_and_password, school).await {
            Ok(auth_token) => EhallDataModel::LoggedIn {
                username_and_password,
                school,
                auth_token,
            },
            Err(_e) => EhallDataModel::NotLoggedIn,
        }
    }

    // pub async fn get_user_info(&mut self) {}

    pub async fn logout(&self) -> Self {
        EhallDataModel::NotLoggedIn
    }
}

async fn login(
    username_and_password: &UsernameAndPassword,
    school: Schcool,
) -> Result<AuthToken, Box<dyn std::error::Error>> {
    let url = format!("{}/{}/cas_login", BACKEND_HOST, school.as_str());
    let client = reqwest::Client::new();
    let response = client
        .post(&url)
        .json(&LoginRequest::from(username_and_password))
        .send()
        .await?;
    let response = response.json::<LoginResponse>().await?;
    response.auth_token.ok_or(response.message.into())
}

pub async fn request_user_info(
    auth_token: &AuthToken,
    school: &Schcool,
) -> Result<RUserInfo, Box<dyn std::error::Error>> {
    let url = format!("{}/{}/user/info", BACKEND_HOST, school.as_str());
    let client = reqwest::Client::new();
    let response = client
        .get(&url)
        .header("Authorization", auth_token)
        .send()
        .await?;
    let response = response.json::<UserInfoResponse>().await?;
    response.data.ok_or(response.message.into())
}

pub async fn request_user_score(
    auth_token: &AuthToken,
    school: &Schcool,
) -> Result<Vec<Score>, Box<dyn std::error::Error>> {
    let url = format!("{}/{}/user/score", BACKEND_HOST, school.as_str());
    let client = reqwest::Client::new();
    let response = client
        .get(&url)
        .header("Authorization", auth_token)
        .send()
        .await?;
    let response = response.json::<ScoreResponse>().await?;
    response.data.ok_or(response.message.into())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[tokio::test]
    async fn test_login() {
        let x = UsernameAndPassword::new("21220513".into(), "283511".into());
        let y = login(&x, Schcool::NanjingNormalUniversity).await;
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
