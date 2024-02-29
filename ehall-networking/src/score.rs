use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct ScoreRequest {
    semester: String,
    amount: u64,
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
pub struct ScoreResponse {
    pub status: String,
    pub message: String,
    pub total_count: u64,
    pub data: Option<Vec<Score>>,
}

#[derive(Debug, Clone, Serialize, Deserialize, uniffi::Record)]
#[serde(rename_all = "camelCase")]
pub struct Score {
    course_name: String,
    exam_time: String,
    course_id: String,
    class_id: String,
    total_score: u64,
    grade_point: String,
    regular_score: Option<String>,
    mid_score: Option<String>,
    final_score: Option<String>,
    regular_percent: Option<String>,
    mid_precent: Option<String>,
    final_precent: Option<String>,
    course_type: String,
    course_cate: String,
    is_retake: String,
    credits: f64,
    grade_type: String,
    semester: String,
    department: String,
}
