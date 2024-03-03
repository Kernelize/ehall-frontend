use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct RUserInfoRequest {}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct RUserInfoResponse {
    pub status: String,
    pub message: String,
    pub data: Option<RUserInfo>,
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct RUserInfo {
    user_name: String,
    user_id: String,
    user_type: RUserType,
    user_sex: RUserSex,
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Enum)]
pub enum RUserType {
    Student,
    Teacher,
}

// #[uniffi::export]
// impl UserType {
//     pub fn as_str(&self) -> &str {
//         match self {
//             UserType::学生 => "学生",
//             UserType::教师 => "教师",
//         }
//     }
// }

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Enum)]
pub enum RUserSex {
    Male,
    Female,
}

// #[uniffi::export]
// impl UserSex {
//     pub fn as_str(&self) -> &str {
//         match self {
//             UserSex::男 => "男",
//             UserSex::女 => "女",
//         }
//     }
// }
