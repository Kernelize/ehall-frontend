use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Copy, Serialize, Deserialize, uniffi::Enum)]
pub enum RSchcool {
    NanjingNormalUniversity,
    YanShanUniversity,
}

impl std::fmt::Display for RSchcool {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            RSchcool::NanjingNormalUniversity => write!(f, "南京师范大学"),
            RSchcool::YanShanUniversity => write!(f, "燕山大学"),
        }
    }
}

impl std::str::FromStr for RSchcool {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "nnu" => Ok(RSchcool::NanjingNormalUniversity),
            "ysu" => Ok(RSchcool::YanShanUniversity),
            _ => Err(format!("{} is not a valid school", s)),
        }
    }
}

impl RSchcool {
    pub fn as_str(&self) -> &str {
        match self {
            RSchcool::NanjingNormalUniversity => "nnu",
            RSchcool::YanShanUniversity => "ysu",
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct RUsernameAndPassword {
    pub username: String,
    pub password: String,
}

impl RUsernameAndPassword {
    pub fn new(username: String, password: String) -> Self {
        Self { username, password }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct RLoginRequest {
    username: String,
    password: String,
}

impl From<&RUsernameAndPassword> for RLoginRequest {
    fn from(username_and_password: &RUsernameAndPassword) -> Self {
        Self {
            username: username_and_password.username.clone(),
            password: username_and_password.password.clone(),
        }
    }
}

impl From<RUsernameAndPassword> for RLoginRequest {
    fn from(username_and_password: RUsernameAndPassword) -> Self {
        Self {
            username: username_and_password.username,
            password: username_and_password.password,
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct RLoginResponse {
    pub status: String,
    pub message: String,
    pub auth_token: Option<RAuthToken>,
}

pub type RAuthToken = String;
