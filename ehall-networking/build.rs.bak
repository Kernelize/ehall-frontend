use uniffi::generate_bindings;
use uniffi::TargetLanguage;

fn main() {
    let udl_file = "./src/ehall-networking.udl";
    let out_dir = "./bindings";
    let languages = vec![
        TargetLanguage::Swift,
        TargetLanguage::Kotlin,
        TargetLanguage::Python,
        TargetLanguage::Ruby,
    ];
    uniffi::generate_scaffolding(udl_file).unwrap();
    generate_bindings(
        udl_file.into(),
        None,
        languages,
        Some(out_dir.into()),
        None,
        None,
        true,
    )
    .unwrap();
}
