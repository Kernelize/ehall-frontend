use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, Serialize, Deserialize, uniffi::Enum)]
pub enum Schcool {
    NanjingNormalUniversity,
    YanShanUniversity,
}

impl std::fmt::Display for Schcool {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            Schcool::NanjingNormalUniversity => write!(f, "南京师范大学"),
            Schcool::YanShanUniversity => write!(f, "燕山大学"),
        }
    }
}

impl std::str::FromStr for Schcool {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "nnu" => Ok(Schcool::NanjingNormalUniversity),
            "ysu" => Ok(Schcool::YanShanUniversity),
            _ => Err(format!("{} is not a valid school", s)),
        }
    }
}

impl Schcool {
    pub fn as_str(&self) -> &str {
        match self {
            Schcool::NanjingNormalUniversity => "nnu",
            Schcool::YanShanUniversity => "ysu",
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct UsernameAndPassword {
    pub username: String,
    pub password: String,
}

impl UsernameAndPassword {
    pub fn new(username: String, password: String) -> Self {
        Self { username, password }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct LoginRequest {
    username: String,
    password: String,
}

impl From<&UsernameAndPassword> for LoginRequest {
    fn from(username_and_password: &UsernameAndPassword) -> Self {
        Self {
            username: username_and_password.username.clone(),
            password: username_and_password.password.clone(),
        }
    }
}

impl From<UsernameAndPassword> for LoginRequest {
    fn from(username_and_password: UsernameAndPassword) -> Self {
        Self {
            username: username_and_password.username,
            password: username_and_password.password,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct LoginResponse {
    pub status: String,
    pub message: String,
    pub auth_token: Option<AuthToken>,
}

pub type AuthToken = String;
