//// Models, decoders and encoders
//// 

import gleam/dynamic.{type Dynamic} as dyn
import gleam/json.{array, bool, int, object, string}
import gleam/list
import gleam/option.{type Option}
import swagger/internal/decode as d

pub fn decode_registration_token(
  json_string json_string: String,
) -> Result(String, json.DecodeError) {
  let decoder = dyn.field("token", dyn.string)

  json.decode(json_string, decoder)
}

pub fn decode_unadopted(
  json_string json_string: String,
) -> Result(List(String), json.DecodeError) {
  let decoder = dyn.list(dyn.string)

  json.decode(json_string, decoder)
}

pub type APIError {
  APIError(message: String, url: String)
}

pub type AccessToken {
  AccessToken(
    id: Int,
    name: String,
    scopes: List(String),
    sha1: String,
    token_last_eight: String,
  )
}

pub type Activity {
  Activity(
    act_user: User,
    act_user_id: Int,
    comment: Comment,
    comment_id: Int,
    content: String,
    created: String,
    id: Int,
    is_private: Bool,
    op_type: String,
    ref_name: String,
    repo: Repository,
    repo_id: Int,
    user_id: Int,
  )
}

pub type ActivityPub {
  ActivityPub(context: String)
}

pub type AddCollaboratorOption {
  AddCollaboratorOption(permission: String)
}

pub type AddTimeOption {
  AddTimeOption(created: String, time: Int, user_name: String)
}

pub type AnnotatedTag {
  AnnotatedTag(
    message: String,
    object: AnnotatedTagObject,
    sha: String,
    tag: String,
    tagger: CommitUser,
    url: String,
    verification: PayloadCommitVerification,
  )
}

pub type AnnotatedTagObject {
  AnnotatedTagObject(sha: String, tag_type: String, url: String)
}

pub type Attachment {
  Attachment(
    browser_download_string: String,
    created_at: String,
    download_count: Int,
    id: Int,
    name: String,
    size: Int,
    uuid: String,
  )
}

pub type BlockedUser {
  BlockedUser(block_id: Int, created_at: String)
}

pub type Branch {
  Branch(
    commit: PayloadCommit,
    effective_branch_protection_name: String,
    enable_status_check: Bool,
    name: String,
    protected: Bool,
    required_approvals: Int,
    status_check_contexts: List(String),
    user_can_merge: Bool,
    user_can_push: Bool,
  )
}

pub type BranchProtection {
  BranchProtection(
    apply_to_admins: Bool,
    approvals_whitelist_teams: List(String),
    approvals_whitelist_username: List(String),
    block_on_official_review_requests: Bool,
    block_on_outdated_branch: Bool,
    block_on_rejected_reviews: Bool,
    branch_name: String,
    created_at: String,
    dismiss_stale_approvals: Bool,
    enable_approvals_whitelist: Bool,
    enable_merge_whitelist: Bool,
    enable_push: Bool,
    enable_push_whitelist: Bool,
    enable_status_check: Bool,
    ignore_stale_approvals: Bool,
    merge_whitelist_teams: List(String),
    merge_whitelist_usernames: List(String),
    protected_file_patterns: String,
    push_whitelist_deploy_keys: Bool,
    push_whitelist_teams: List(String),
    push_whitelist_usernames: List(String),
    require_signed_commits: Bool,
    required_approvals: Int,
    rule_name: String,
    status_check_contexts: List(String),
    unprotected_file_patterns: String,
    updated_at: String,
  )
}

pub type FileOperation {
  Create
  Update
  Delete
}

pub type ChangeFileOperation {
  ChangeFileOperation(
    content: String,
    fromt_path: String,
    operation: FileOperation,
    path: String,
    sha: String,
  )
}

pub type ChangeFileOptions {
  ChangeFileOptions(
    author: Option(Identity),
    branch: Option(String),
    commiter: Option(Identity),
    dates: CommitDateOptions,
    files: List(ChangeFileOperation),
    message: Option(String),
    new_branch: Option(String),
    signoff: Bool,
  )
}

pub type ChangedFile {
  ChangedFile(
    additions: Int,
    changes: Int,
    contents_url: String,
    deletions: Int,
    filename: String,
    html_url: String,
    previous_filename: String,
    raw_url: String,
    status: String,
  )
}

pub type CombinedStatus {
  CombinedStatus(
    commit_url: String,
    repository: Repository,
    sha: String,
    state: CommitStatusState,
    statuses: List(CommitStatus),
    total_count: Int,
    url: String,
  )
}

pub type Comment {
  Comment(
    assets: List(Attachment),
    body: String,
    created_at: String,
    html_url: String,
    id: Int,
    issue_url: String,
    original_author: String,
    original_author_id: Int,
    pull_request_url: String,
    updated_at: String,
    user: User,
  )
}

pub type Commit {
  Commit(
    author: User,
    commit: RepoCommit,
    committer: User,
    created: String,
    files: List(CommitAffectedFiles),
    html_url: String,
    parents: List(CommitMeta),
    sha: String,
    stats: CommitStats,
    url: String,
  )
}

pub type CommitAffectedFiles {
  CommitAffectedFiles(filename: String, status: String)
}

pub type CommitDateOptions {
  CommitDateOptions(author: String, committer: String)
}

pub type CommitMeta {
  CommitMeta(created: String, sha: String, url: String)
}

pub type CommitStats {
  CommitStats(additions: Int, deletions: Int, total: Int)
}

pub type CommitStatus {
  CommitStatus(
    context: String,
    created_at: String,
    creator: User,
    description: String,
    id: Int,
    status: CommitStatusState,
    target_url: String,
    updated_at: String,
    url: String,
  )
}

pub type CommitStatusState {
  Pending
  Success
  Error
  Failure
}

pub type CommitUser {
  CommitUser(date: String, email: String, name: String)
}

pub type ContentsResponseType {
  File
  Dir
  Symlink
  Submodule
}

pub type ContentsResponse {
  ContentsResponse(
    links: FileLinksResponse,
    content: Option(String),
    download_url: String,
    encoding: Option(String),
    git_url: String,
    html_url: String,
    last_commit_sha: String,
    name: String,
    path: String,
    sha: String,
    size: Int,
    submodule_git_url: Option(String),
    target: Option(String),
    response_type: ContentsResponseType,
    url: String,
  )
}

pub type CreateAccessTokenOption {
  CreateAccessTokenOption(name: String, scopes: List(String))
}

pub type CreateBranchProtectionOption {
  CreateBranchProtectionOption(
    apply_to_admins: Bool,
    approvals_whitelist_teams: List(String),
    approvals_whitelist_username: List(String),
    block_on_official_review_requests: Bool,
    block_on_outdated_branch: Bool,
    block_on_rejected_reviews: Bool,
    branch_name: String,
    dismiss_stale_approvals: Bool,
    enable_approvals_whitelist: Bool,
    enable_merge_whitelist: Bool,
    enable_push: Bool,
    enable_push_whitelist: Bool,
    enable_status_check: Bool,
    ignore_stale_approvals: Bool,
    merge_whitelist_teams: List(String),
    merge_whitelist_usernames: List(String),
    protected_file_patterns: String,
    push_whitelist_deploy_keys: Bool,
    push_whitelist_teams: List(String),
    push_whitelist_usernames: List(String),
    require_signed_commits: Bool,
    required_approvals: Int,
    rule_name: String,
    status_check_contexts: List(String),
    unprotected_file_patterns: String,
  )
}

pub type CreateBranchRepoOption {
  CreateBranchRepoOption(
    new_branch_name: String,
    old_branch_name: String,
    old_ref_name: String,
  )
}

pub type CreateEmailOption {
  CreateEmailOption(emails: List(String))
}

pub type CreateFileOptions {
  CreateFileOptions(
    author: Option(Identity),
    branch: Option(String),
    commiter: Option(Identity),
    content: String,
    dates: CommitDateOptions,
    message: Option(String),
    new_branch: Option(String),
    signoff: Bool,
  )
}

pub type CreateForkOption {
  CreateForkOption(name: String, organization: String)
}

pub type CreateGPGKeyOption {
  CreateGPGKeyOption(armored_public_key: String, armored_signature: String)
}

pub type HookType {
  ForgejoHook
  DingtalkHook
  DiscordHook
  GiteaHook
  GogsHook
  MSTeamsHook
  SlackHook
  TelegramHook
  FeishuHook
  WeChatWorkHook
  PackagistHook
}

/// Converts a [HookType](#HookType) to a string
/// 
pub fn encode_hook_type(hook_type hook_type: HookType) -> String {
  case hook_type {
    ForgejoHook -> "forgejo"
    DingtalkHook -> "dingtalk"
    DiscordHook -> "discord"
    GiteaHook -> "gitea"
    GogsHook -> "gogs"
    MSTeamsHook -> "msteams"
    SlackHook -> "slack"
    TelegramHook -> "telegram"
    FeishuHook -> "feishu"
    WeChatWorkHook -> "wechatwork"
    PackagistHook -> "packagist"
  }
}

pub type CreateHookOption {
  CreateHookOption(
    active: Bool,
    authorization_header: String,
    branch_filter: String,
    config: CreateHookOptionConfig,
    events: List(String),
    hook_type: HookType,
  )
}

/// Encodes a [CreateHookOption](#CreateHookOption) into a Json string
/// 
pub fn encode_create_hook_option(
  hook_option hook_option: CreateHookOption,
) -> String {
  object([
    #("active", bool(hook_option.active)),
    #("authorization_header", string(hook_option.authorization_header)),
    #("branch_filter", string(hook_option.branch_filter)),
    #(
      "config",
      object(
        hook_option.config.options
        |> list.map(fn(x) { #(x.0, string(x.1)) }),
      ),
    ),
    #("events", array(hook_option.events, string)),
    #("type", string(hook_option.hook_type |> encode_hook_type)),
  ])
  |> json.to_string
}

pub type CreateHookOptionConfig {
  CreateHookOptionConfig(options: List(#(String, String)))
}

pub type CreateIssueCommentOption {
  CreateIssueCommentOption(body: String, updated_at: String)
}

pub type CreateIssueOption {
  CreateIssueOption(
    assignee: String,
    assignees: List(String),
    body: String,
    closed: Bool,
    due_date: String,
    labels: List(Int),
    milestone: Int,
    ref: String,
    title: String,
  )
}

pub type CreateKeyOption {
  CreateKeyOption(key: String, read_only: Bool, title: String)
}

/// Encodes a [CreateKeyOption](#CreateKeyOption) into a Json string
/// 
pub fn encode_create_key_option(
  key_option key_option: CreateKeyOption,
) -> String {
  object([
    #("key", string(key_option.key)),
    #("read_only", bool(key_option.read_only)),
    #("title", string(key_option.title)),
  ])
  |> json.to_string
}

pub type CreateLabelOption {
  CreateLabelOption(
    color: String,
    description: String,
    exclusive: Bool,
    is_archived: Bool,
    name: String,
  )
}

pub type MilestoneState {
  Open
  Closed
}

pub type CreateMilestoneOption {
  CreateMilestoneOption(
    description: String,
    due_on: String,
    state: MilestoneState,
    title: String,
  )
}

pub type CreateOAuth2ApplicationOptions {
  CreateOAuth2ApplicationOptions(
    confidential_client: Bool,
    name: String,
    redirect_uris: List(String),
  )
}

pub type CreateOrUpdateSecretOption {
  CreateOrUpdateSecretOption(data: String)
}

pub type OrgVisibility {
  Public
  Limited
  Private
}

/// Converts an [OrgVisibility](#OrgVisibility) to a string
/// 
pub fn encode_org_visibility(visibility visibility: OrgVisibility) -> String {
  case visibility {
    Public -> "public"
    Limited -> "limited"
    Private -> "private"
  }
}

pub type CreateOrgOption {
  CreateOrgOption(
    description: String,
    email: String,
    full_name: String,
    location: String,
    repo_admin_change_team_access: Bool,
    username: String,
    visibility: OrgVisibility,
    website: String,
  )
}

/// Encodes a [CreateOrgOption](#CreateOrgOption) into a Json string
/// 
pub fn encode_create_org_option(
  org_option org_option: CreateOrgOption,
) -> String {
  object([
    #("description", string(org_option.description)),
    #("email", string(org_option.email)),
    #("full_name", string(org_option.full_name)),
    #("location", string(org_option.location)),
    #(
      "repo_admin_change_team_access",
      bool(org_option.repo_admin_change_team_access),
    ),
    #("username", string(org_option.username)),
    #("visibility", string(org_option.visibility |> encode_org_visibility)),
    #("website", string(org_option.website)),
  ])
  |> json.to_string
}

pub type CreatePullRequestOption {
  CreatePullRequestOption(
    assignee: String,
    assignees: List(String),
    base: String,
    body: String,
    due_date: String,
    head: String,
    labels: List(Int),
    milestone: Int,
    title: String,
  )
}

pub type CreatePullReviewComment {
  CreatePullReviewComment(
    body: String,
    new_position: Int,
    old_position: Int,
    path: String,
  )
}

pub type CreatePullReviewOptions {
  CreatePullReviewOptions(
    body: String,
    comments: List(CreatePullReviewComment),
    commit_id: String,
    evemt: ReviewStateType,
  )
}

pub type CreatePushMirrorOption {
  CreatePushMirrorOption(
    interval: String,
    remote_address: String,
    remote_password: String,
    remote_username: String,
    sync_on_commit: Bool,
  )
}

pub type CreateReleaseOption {
  CreateReleaseOption(
    body: String,
    draft: Bool,
    name: String,
    prerelease: Bool,
    tag_name: String,
    target_commitish: String,
  )
}

pub type TrustModel {
  Default
  Collaborator
  Comitter
  CollaboratorCommitter
}

pub fn encode_trust_model(model model: TrustModel) -> String {
  case model {
    Default -> "default"
    Collaborator -> "collaborator"
    Comitter -> "comitter"
    CollaboratorCommitter -> "collaboratorcomitter"
  }
}

pub type ObjectFormat {
  Sha1
  Sha256
}

fn object_format_from_string(format: String) -> ObjectFormat {
  case format {
    "sha1" -> Sha1
    "sha256" -> Sha256
    _ -> todo as "unknown object format"
  }
}

/// Converts an [ObjectFormat](#ObjectFormat) to a string
/// 
pub fn encode_object_format(format format: ObjectFormat) -> String {
  case format {
    Sha1 -> "sha1"
    Sha256 -> "sha256"
  }
}

pub type CreateRepoOption {
  CreateRepoOption(
    auto_init: Bool,
    default_branch: String,
    description: String,
    gitignores: String,
    issue_labels: String,
    license: String,
    name: Bool,
    object_format_name: ObjectFormat,
    private: Bool,
    readme: String,
    template: Bool,
    trust_model: TrustModel,
  )
}

/// Encodes a [CreateHookOption](#CreateHookOption) into a Json string
/// 
pub fn encode_create_repo_option(
  repo_option repo_option: CreateRepoOption,
) -> String {
  object([
    #("auto_init", bool(repo_option.auto_init)),
    #("default_branch", string(repo_option.default_branch)),
    #("description", string(repo_option.description)),
    #("gitignores", string(repo_option.gitignores)),
    #("issue_labels", string(repo_option.issue_labels)),
    #("license", string(repo_option.license)),
    #("name", bool(repo_option.name)),
    #(
      "object_format",
      string(repo_option.object_format_name |> encode_object_format),
    ),
    #("private", bool(repo_option.private)),
    #("readme", string(repo_option.readme)),
    #("template", bool(repo_option.template)),
    #("trust_model", string(repo_option.trust_model |> encode_trust_model)),
  ])
  |> json.to_string
}

pub type CreateStatusOption {
  CreateStatusOption(
    context: String,
    description: String,
    state: CommitStatusState,
    target_url: String,
  )
}

pub type CreateTagOption {
  CreateTagOption(message: String, tag_name: String, target: String)
}

pub type TeamPermissions {
  None
  Read
  Write
  Admin
  Owner
}

fn team_permissions_from_string(permission: String) -> TeamPermissions {
  case permission {
    "none" -> None
    "read" -> Read
    "write" -> Write
    "admin" -> Admin
    "owner" -> Owner
    _ -> todo as "unknown team permission"
  }
}

pub type CreateTeamOption {
  CreateTeamOption(
    can_create_org_repo: Bool,
    description: String,
    includes_all_repositories: Bool,
    name: String,
    permissison: TeamPermissions,
    units: List(String),
    units_map: List(#(String, String)),
  )
}

pub type CreateUserOption {
  CreateUserOption(
    created_at: String,
    email: String,
    full_name: String,
    login_name: String,
    must_change_password: Bool,
    password: String,
    restricted: Bool,
    send_notify: Bool,
    source_id: Int,
    username: String,
    visibility: String,
  )
}

/// Encodes a [CreateUserOption](#CreateUserOption) into a Json string
/// 
pub fn encode_create_user_option(
  user_option user_option: CreateUserOption,
) -> String {
  object([
    #("created_at", string(user_option.created_at)),
    #("email", string(user_option.email)),
    #("full_name", string(user_option.full_name)),
    #("login_name", string(user_option.login_name)),
    #("must_change_password", bool(user_option.must_change_password)),
    #("password", string(user_option.password)),
    #("restricted", bool(user_option.restricted)),
    #("send_notify", bool(user_option.send_notify)),
    #("source_id", int(user_option.source_id)),
    #("username", string(user_option.username)),
    #("visibility", string(user_option.visibility)),
  ])
  |> json.to_string
}

pub type CreateWikiPageOptions {
  CreateWikiPageOptions(content_base64: String, message: String, title: String)
}

pub type Cron {
  Cron(
    exec_times: Int,
    name: String,
    next: String,
    prev: String,
    schedule: String,
  )
}

fn cron_decoder() -> d.Decoder(Cron) {
  d.into({
    use exec_times <- d.parameter
    use name <- d.parameter
    use next <- d.parameter
    use prev <- d.parameter
    use schedule <- d.parameter
    Cron(exec_times, name, next, prev, schedule)
  })
  |> d.field("exec_times", d.int)
  |> d.field("name", d.string)
  |> d.field("next", d.string)
  |> d.field("prev", d.string)
  |> d.field("schedule", d.string)
}

pub fn decode_cron_list(
  json_string json_string: String,
) -> Result(List(Cron), json.DecodeError) {
  use data <- json.decode(json_string)
  d.list(cron_decoder())
  |> d.run(data)
}

pub type DeleteEmailOption {
  DeleteEmailOption(emails: List(String))
}

pub type DeleteFileOptions {
  DeleteFileOptions(
    author: Option(Identity),
    branch: Option(String),
    commiter: Option(Identity),
    dates: CommitDateOptions,
    message: Option(String),
    new_branch: Option(String),
    signoff: Bool,
  )
}

pub type DeleteLabelOption {
  DeleteLabelOption(updated_at: String)
}

pub type DeployKey {
  DeployKey(
    created_at: String,
    fingerprint: String,
    id: Int,
    key: String,
    key_id: Int,
    read_only: Bool,
    repository: Repository,
    title: String,
    url: String,
  )
}

pub type DismissPullReviewOptions {
  DismissPullReviewOptions(message: String, priors: Bool)
}

pub type EditAttachmentOptions {
  EditAttachmentOptions(name: String)
}

pub type EditBranchProtectionOption {
  EditBranchProtectionOption(
    apply_to_admins: Bool,
    approvals_whitelist_teams: List(String),
    approvals_whitelist_username: List(String),
    block_on_official_review_requests: Bool,
    block_on_outdated_branch: Bool,
    block_on_rejected_reviews: Bool,
    dismiss_stale_approvals: Bool,
    enable_approvals_whitelist: Bool,
    enable_merge_whitelist: Bool,
    enable_push: Bool,
    enable_push_whitelist: Bool,
    enable_status_check: Bool,
    ignore_stale_approvals: Bool,
    merge_whitelist_teams: List(String),
    merge_whitelist_usernames: List(String),
    protected_file_patterns: String,
    push_whitelist_deploy_keys: Bool,
    push_whitelist_teams: List(String),
    push_whitelist_usernames: List(String),
    require_signed_commits: Bool,
    required_approvals: Int,
    status_check_contexts: List(String),
    unprotected_file_patterns: String,
  )
}

pub type EditDeadlineOption {
  EditDeadlineOption(due_date: String)
}

pub type EditGitHookOption {
  EditGitHookOption(content: String)
}

pub type EditHookOption {
  EditHookOption(
    active: Bool,
    authorization_header: String,
    branch_filter: String,
    config: List(#(String, String)),
    events: List(String),
  )
}

/// Encodes an [EditHookOption](#EditHookOption) into a Json string
/// 
pub fn encode_edit_hook_option(
  hook_option hook_option: EditHookOption,
) -> String {
  object([
    #("active", bool(hook_option.active)),
    #("authorization_header", string(hook_option.authorization_header)),
    #("branch_filter", string(hook_option.branch_filter)),
    #(
      "config",
      object(
        hook_option.config
        |> list.map(fn(x) { #(x.0, string(x.1)) }),
      ),
    ),
    #("events", array(hook_option.events, string)),
  ])
  |> json.to_string
}

pub type EditIssueCommentOption {
  EditIssueCommentOption(body: String, updat: String)
}

pub type EditIssueOption {
  EditIssueOption(
    assignee: String,
    assignees: List(String),
    body: String,
    due_date: String,
    milestone: Int,
    ref: String,
    state: String,
    title: String,
    unset_due_date: String,
    updated_at: String,
  )
}

pub type EditLabelOption {
  EditLabelOption(
    color: String,
    description: String,
    exclusive: Bool,
    is_archived: Bool,
    name: String,
  )
}

pub type EditMilestoneOption {
  EditMilestoneOption(
    description: String,
    due_on: String,
    state: String,
    title: String,
  )
}

pub type EditOrgOption {
  EditOrgOption(
    description: String,
    email: String,
    full_name: String,
    location: String,
    repo_admin_change_team_access: Bool,
    visibility: OrgVisibility,
    website: String,
  )
}

pub type EditPullRequestOption {
  EditPullRequestOption(
    allow_maintainer_edit: Bool,
    assignee: String,
    assignees: List(String),
    base: String,
    body: String,
    due_date: String,
    labels: Int,
    milestone: Int,
    state: String,
    title: String,
    unset_due_date: Bool,
  )
}

pub type EditReactionOption {
  EditReactionOption(content: String)
}

pub type EditReleaseOption {
  EditReleaseOption(
    body: String,
    draft: Bool,
    name: String,
    prerelease: Bool,
    tag_name: String,
    target_commitish: String,
  )
}

pub type MergeStyle {
  Merge
  Rebase
  RebaseMerge
  Squash
  FastForwardOnly
  ManuallyMerged
}

pub type EditRepoOption {
  EditRepoOption(
    allow_fast_forward_only_merge: Bool,
    allow_manual_merge: Bool,
    allow_merge_commits: Bool,
    allow_rebase: Bool,
    allow_rebase_explicit: Bool,
    allow_rebase_update: Bool,
    allow_squash_merge: Bool,
    archived: Bool,
    autodetect_manual_merge: Bool,
    default_allow_maintainer_edit: Bool,
    default_branch: String,
    default_delete_branch_after_merge: Bool,
    default_merge_style: MergeStyle,
    description: String,
    enable_prune: Bool,
    external_tracker: ExternalTracker,
    external_wiki: ExternalWiki,
    has_actions: Bool,
    has_issues: Bool,
    has_packages: Bool,
    has_projects: Bool,
    has_pull_requests: Bool,
    has_releases: Bool,
    has_wiki: Bool,
    ignore_whitespace_conflicts: Bool,
    internal_tracker: InternalTracker,
    mirror_interval: String,
    name: String,
    private: Bool,
    template: Bool,
    website: String,
    wiki_branch: String,
  )
}

pub type EditTeamOption {
  EditTeamOption(
    description: String,
    can_create_org_repo: Bool,
    includes_all_repositories: Bool,
    name: String,
    permission: TeamPermissions,
    units: List(String),
    units_map: List(#(String, String)),
  )
}

pub type EditUserOption {
  EditUserOption(
    active: Bool,
    admin: Bool,
    allow_create_organization: Bool,
    allow_git_hook: Bool,
    allow_import_local: Bool,
    description: String,
    email: String,
    full_name: String,
    location: String,
    login_name: String,
    max_repo_creation: Int,
    must_change_password: Bool,
    password: String,
    prohibit_login: Bool,
    pronouns: String,
    restricted: Bool,
    source_id: Int,
    visibility: String,
    website: String,
  )
}

/// Encodes a [EditUserOption](#EditUserOption) into a Json string
/// 
pub fn encode_edit_user_option(
  user_option user_option: EditUserOption,
) -> String {
  object([
    #("active", bool(user_option.active)),
    #("admin", bool(user_option.admin)),
    #("allow_create_organization", bool(user_option.allow_create_organization)),
    #("allow_git_hook", bool(user_option.allow_git_hook)),
    #("allow_import_local", bool(user_option.allow_import_local)),
    #("description", string(user_option.description)),
    #("email", string(user_option.email)),
    #("full_name", string(user_option.full_name)),
    #("location", string(user_option.location)),
    #("login_name", string(user_option.login_name)),
    #("max_repo_creation", int(user_option.max_repo_creation)),
    #("must_change_password", bool(user_option.must_change_password)),
    #("password", string(user_option.password)),
    #("prohibit_login", bool(user_option.prohibit_login)),
    #("pronouns", string(user_option.pronouns)),
    #("restricted", bool(user_option.restricted)),
    #("source_id", int(user_option.source_id)),
    #("visibility", string(user_option.visibility)),
    #("website", string(user_option.website)),
  ])
  |> json.to_string
}

pub type Email {
  Email(
    email: String,
    primary: Bool,
    user_id: Int,
    username: String,
    verified: Bool,
  )
}

fn email_decoder() -> d.Decoder(Email) {
  d.into({
    use email <- d.parameter
    use primary <- d.parameter
    use user_id <- d.parameter
    use username <- d.parameter
    use verified <- d.parameter
    Email(email, primary, user_id, username, verified)
  })
  |> d.field("email", d.string)
  |> d.field("primary", d.bool)
  |> d.field("user_id", d.int)
  |> d.field("username", d.string)
  |> d.field("verified", d.bool)
}

pub fn decode_email_list(
  json_string json_string: String,
) -> Result(List(Email), json.DecodeError) {
  use data <- json.decode(json_string)
  d.list(email_decoder())
  |> d.run(data)
}

pub fn decode_email(
  json_string json_string: String,
) -> Result(Email, json.DecodeError) {
  use data <- json.decode(json_string)
  email_decoder()
  |> d.run(data)
}

pub type ExternalTrackerStyle {
  Numeric
  Alphanumeric
  Regexp
}

fn external_tracker_style_from_string(style: String) -> ExternalTrackerStyle {
  case style {
    "numeric" -> Numeric
    "alphanumeric" -> Alphanumeric
    "regexp" -> Regexp
    _ -> todo as "Unknown style"
  }
}

pub type ExternalTracker {
  ExternalTracker(
    external_tracker_format: String,
    external_tracker_regexp_pattern: String,
    external_tracker_style: ExternalTrackerStyle,
    external_tracker_url: String,
  )
}

fn external_tracker_decoder() -> d.Decoder(ExternalTracker) {
  d.into({
    use external_tracker_format <- d.parameter
    use external_tracker_regexp_pattern <- d.parameter
    use external_tracker_style <- d.parameter
    use external_tracker_url <- d.parameter
    ExternalTracker(
      external_tracker_format,
      external_tracker_regexp_pattern,
      external_tracker_style |> external_tracker_style_from_string,
      external_tracker_url,
    )
  })
  |> d.field("external_tracker_format", d.string)
  |> d.field("external_tracker_regexp_pattern", d.string)
  |> d.field("external_tracker_style", d.string)
  |> d.field("external_tracker_url", d.string)
}

pub type ExternalWiki {
  ExternalWiki(external_wiki_url: String)
}

fn external_wiki_decoder() -> d.Decoder(ExternalWiki) {
  d.into({
    use external_wiki_url <- d.parameter
    ExternalWiki(external_wiki_url)
  })
  |> d.field("external_wiki_url", d.string)
}

pub type FileCommitResponse {
  FileCommitResponse(
    author: CommitUser,
    committer: CommitUser,
    created: String,
    html_url: String,
    message: String,
    parents: List(CommitMeta),
    sha: String,
    tree: CommitMeta,
    url: String,
  )
}

pub type FileDeleteResponse {
  FileDeleteResponse(
    commit: FileCommitResponse,
    content: Dynamic,
    verification: PayloadCommitVerification,
  )
}

pub type FileLinksResponse {
  FileLinksResponse(git: String, html: String, self: String)
}

pub type FileResponse {
  FileResponse(
    commit: FileCommitResponse,
    content: ContentsResponse,
    verification: PayloadCommitVerification,
  )
}

pub type FilesResponse {
  FilesResponse(
    commit: FileCommitResponse,
    files: List(ContentsResponse),
    verification: PayloadCommitVerification,
  )
}

pub type GPGKey {
  GPGKey(
    can_certify: Bool,
    can_encrypt_comms: Bool,
    can_encrypt_storage: Bool,
    can_sign: Bool,
    created_at: String,
    emails: List(GPGKeyEmail),
    expires_at: String,
    id: Int,
    key_id: String,
    primary_key_id: String,
    public_key: String,
    subkeys: List(GPGKey),
    verified: Bool,
  )
}

pub type GPGKeyEmail {
  GPGKeyEmail(email: String, verified: Bool)
}

pub type GeneralAPISettings {
  GeneralAPISettings(
    default_git_trees_per_page: Int,
    default_max_blob_size: Int,
    default_paging_num: Int,
    max_response_items: Int,
  )
}

pub type GeneralAttachmentSettings {
  GeneralAttachmentSettings(
    allowed_types: String,
    enabled: Bool,
    max_size: Int,
    max_files: Int,
  )
}

pub type GeneralRepoSettings {
  GeneralRepoSettings(
    forks_disabled: Bool,
    http_git_diabled: Bool,
    lfs_disabled: Bool,
    migrations_disabled: Bool,
    mirrors_disabled: Bool,
    starts_disabled: Bool,
    time_tracking_disabled: Bool,
  )
}

pub type GeneralUISettings {
  GeneralUISettings(
    allowed_reactions: List(String),
    custom_emojis: List(String),
    default_theme: String,
  )
}

pub type GenerateRepoOption {
  GenerateRepoOption(
    avatar: Bool,
    default_branch: String,
    description: String,
    git_content: Bool,
    git_hooks: Bool,
    labels: Bool,
    name: String,
    owner: String,
    private: Bool,
    protected_branch: Bool,
    topics: Bool,
    webhooks: Bool,
  )
}

pub type GitBlobResponse {
  GitBlobResponse(
    content: String,
    encoding: String,
    sha: String,
    size: Int,
    url: String,
  )
}

pub type GitEntry {
  GitEntry(
    mode: String,
    path: String,
    sha: String,
    size: Int,
    entry_type: String,
    url: String,
  )
}

pub type GitHook {
  GitHook(content: String, is_active: Bool, name: String)
}

pub type GitObject {
  GitObject(sha: String, object_type: String, url: String)
}

pub type GitTreeResponse {
  GitTreeResponse(
    page: Int,
    sha: String,
    total_count: Int,
    tree: List(GitEntry),
    truncated: Bool,
    url: String,
  )
}

pub type GitignoreTemplateInfo {
  GitignoreTemplateInfo(name: String, source: String)
}

pub type Hook {
  Hook(
    active: Bool,
    authorization_header: String,
    branch_filter: String,
    config: List(#(String, String)),
    content_type: String,
    created_at: String,
    events: List(String),
    id: Int,
    metadata: Dynamic,
    hook_type: String,
    updated_at: String,
    url: String,
  )
}

fn hook_decoder() -> d.Decoder(Hook) {
  d.into({
    use active <- d.parameter
    use authorization_header <- d.parameter
    use branch_filter <- d.parameter
    use config <- d.parameter
    use content_type <- d.parameter
    use created_at <- d.parameter
    use events <- d.parameter
    use id <- d.parameter
    use metadata <- d.parameter
    use hook_type <- d.parameter
    use updated_at <- d.parameter
    use url <- d.parameter
    Hook(
      active,
      authorization_header,
      branch_filter,
      config,
      content_type,
      created_at,
      events,
      id,
      metadata,
      hook_type,
      updated_at,
      url,
    )
  })
  |> d.field("active", d.bool)
  |> d.field("authorization_header", d.string)
  |> d.field("branch_filter", d.string)
  |> d.field("config", d.list(d.tuple2(d.string, d.string)))
  |> d.field("content_type", d.string)
  |> d.field("created_at", d.string)
  |> d.field("events", d.list(d.string))
  |> d.field("id", d.int)
  |> d.field("metadata", d.dynamic)
  |> d.field("type", d.string)
  |> d.field("updated_at", d.string)
  |> d.field("url", d.string)
}

pub fn decode_hook_list(
  json_string json_string: String,
) -> Result(List(Hook), json.DecodeError) {
  use data <- json.decode(json_string)
  d.list(hook_decoder())
  |> d.run(data)
}

pub fn decode_hook(
  json_string json_string: String,
) -> Result(Hook, json.DecodeError) {
  use data <- json.decode(json_string)
  hook_decoder()
  |> d.run(data)
}

pub type Identity {
  Identity(email: String, name: String)
}

pub type InternalTracker {
  InternalTracker(
    allow_only_contributors_to_track_time: Bool,
    enable_issue_dependecies: Bool,
    enable_time_tracker: Bool,
  )
}

fn internal_tracker_decoder() -> d.Decoder(InternalTracker) {
  d.into({
    use allow_only_contributors_to_track_time <- d.parameter
    use enable_issue_dependecies <- d.parameter
    use enable_time_tracker <- d.parameter
    InternalTracker(
      allow_only_contributors_to_track_time,
      enable_issue_dependecies,
      enable_time_tracker,
    )
  })
  |> d.field("allow_only_contributors_to_track_time", d.bool)
  |> d.field("enable_issue_dependecies", d.bool)
  |> d.field("enable_time_tracker", d.bool)
}

pub type Issue {
  Issue(
    assets: List(Attachment),
    assignee: User,
    assignees: List(User),
    body: String,
    closed_at: String,
    comments: Int,
    created_at: String,
    due_date: String,
    html_url: String,
    id: Int,
    is_locked: Bool,
    labels: List(Label),
    milestone: Milestone,
    number: Int,
    original_author: String,
    original_author_id: Int,
    pin_order: Int,
    pull_request: PullRequestMeta,
    ref: String,
    repository: RepositoryMeta,
    state: StateType,
    title: String,
    updated_at: String,
    url: String,
    user: User,
  )
}

pub type IssueConfig {
  IssueConfig(
    blank_issues_enabled: Bool,
    contact_links: List(IssueConfigContactLink),
  )
}

pub type IssueConfigContactLink {
  IssueConfigContactLink(about: String, name: String, url: String)
}

pub type IssueConfigValidation {
  IssueConfigValidation(message: String, valid: Bool)
}

pub type IssueDeadline {
  IssueDeadline(due_date: String)
}

pub type IssueFormField {
  IssueFormField(
    attributes: Dynamic,
    id: String,
    issue_form_field_type: IssueFormFieldType,
    validations: Dynamic,
    visible: List(IssueFormFieldVisible),
  )
}

pub type IssueFormFieldType {
  Markdown
  TextArea
  Input
  Dropdown
  Checkboxes
}

pub type IssueFormFieldVisible {
  IssueFormFieldVisible(String)
}

pub type IssueLabelsOption {
  IssueLabelsOption(labels: List(Int), updated_at: String)
}

pub type IssueMeta {
  IssueMeta(index: Int, owner: String, repo: String)
}

pub type IssueTemplate {
  IssueTemplate(
    about: String,
    body: List(IssueFormField),
    content: String,
    file_name: String,
    labels: IssueTemplateLabels,
    name: String,
    ref: String,
    title: String,
  )
}

pub type IssueTemplateLabels {
  IssueTemplateLabels(List(String))
}

pub type Label {
  Label(
    color: String,
    description: String,
    exclusive: Bool,
    id: Int,
    is_archived: Bool,
    name: String,
    url: String,
  )
}

pub type LabelTemplate {
  LabelTemplate(
    color: String,
    description: String,
    exclusive: Bool,
    name: String,
  )
}

pub type LicenseTemplateInfo {
  LicenseTemplateInfo(
    body: String,
    implementation: String,
    key: String,
    name: String,
    url: String,
  )
}

pub type LicensesTemplateListEntry {
  LicensesTemplateListEntry(key: String, name: String, url: String)
}

pub type MarkdownOption {
  MarkdownOption(context: String, mode: String, text: String, wiki: Bool)
}

pub type MarkupOption {
  MarkupOption(
    context: String,
    filepath: String,
    mode: String,
    text: String,
    wiki: Bool,
  )
}

pub type MergePullRequestOption {
  MergePullRequestOption(
    do: MergeStyle,
    merge_commit_id: String,
    merge_message_field: String,
    merge_title_field: String,
    delete_branch_after_merge: Bool,
    force_merge: Bool,
    head_commit_id: String,
    merge_when_checks_succeed: Bool,
  )
}

pub type Service {
  Git
  Github
  Gitea
  Gitlab
  Gogs
  Onedev
  Gitbucket
  Codebase
}

pub type MigrateRepoOptions {
  MigrateRepoOptions(
    auth_password: String,
    auth_token: String,
    auth_username: String,
    clone_addr: String,
    description: String,
    issues: Bool,
    labels: Bool,
    lfs: Bool,
    lfs_endpoint: String,
    milestones: Bool,
    mirror: Bool,
    mirror_interval: String,
    private: Bool,
    pull_requests: Bool,
    releases: Bool,
    repo_name: String,
    repo_owner: String,
    service: Service,
    uid: Int,
    wiki: Bool,
  )
}

pub type Milestone {
  Milestone(
    closed_at: String,
    closed_issues: Int,
    created_at: String,
    description: String,
    due_on: String,
    id: Int,
    open_issues: Int,
    state: StateType,
    title: String,
    updated_at: String,
  )
}

pub type NewIssuePinsAllowed {
  NewIssuePinsAllowed(issues: Bool, pull_requests: Bool)
}

pub type NodeInfo {
  NodeInfo(
    metadata: Dynamic,
    open_registrations: Bool,
    protocols: List(String),
    services: NodeInfoServices,
    software: NodeInfoSoftware,
    usage: NodeInfoUsage,
    version: String,
  )
}

pub type NodeInfoServices {
  NodeInfoServices(inbound: List(String), outbound: List(String))
}

pub type NodeInfoSoftware {
  NodeInfoSoftware(
    homepage: String,
    name: String,
    repository: String,
    version: String,
  )
}

pub type NodeInfoUsage {
  NodeInfoUsage(
    local_comments: Int,
    local_posts: Int,
    users: NodeInfoUsageUsers,
  )
}

pub type NodeInfoUsageUsers {
  NodeInfoUsageUsers(active_hald_year: Int, active_month: Int, total: Int)
}

pub type Note {
  Note(commit: Commit, message: String)
}

pub type NotificationCount {
  NotificationCount(new: Int)
}

pub type NotificationSubject {
  NotificationSubject(
    html_url: String,
    latest_comment_html_url: String,
    latest_comment_url: String,
    state: StateType,
    title: String,
    notification_type: NotifySubjectType,
    url: String,
  )
}

pub type NotificationThread {
  NotificationThread(
    id: Int,
    pinned: Bool,
    repository: Repository,
    subject: NotificationSubject,
    unread: Bool,
    updated_at: String,
    url: String,
  )
}

pub type NotifySubjectType {
  NotifySubjectType(String)
}

pub type OAuth2Application {
  OAuth2Application(
    client_id: String,
    client_secret: String,
    confidential_client: Bool,
    created: String,
    id: Int,
    name: String,
    redirect_uris: List(String),
  )
}

pub type Organization {
  Organization(
    avatar_url: String,
    description: String,
    email: String,
    full_name: String,
    id: Int,
    location: String,
    name: String,
    repo_admin_change_team_access: Bool,
    username: String,
    visibility: String,
    website: String,
  )
}

fn organization_decoder() -> d.Decoder(Organization) {
  d.into({
    use avatar_url <- d.parameter
    use description <- d.parameter
    use email <- d.parameter
    use full_name <- d.parameter
    use id <- d.parameter
    use location <- d.parameter
    use name <- d.parameter
    use repo_admin_change_team_access <- d.parameter
    use username <- d.parameter
    use visibility <- d.parameter
    use website <- d.parameter
    Organization(
      avatar_url,
      description,
      email,
      full_name,
      id,
      location,
      name,
      repo_admin_change_team_access,
      username,
      visibility,
      website,
    )
  })
  |> d.field("avatar_url", d.string)
  |> d.field("description", d.string)
  |> d.field("email", d.string)
  |> d.field("full_name", d.string)
  |> d.field("id", d.int)
  |> d.field("location", d.string)
  |> d.field("name", d.string)
  |> d.field("repo_admin_change_team_access", d.bool)
  |> d.field("username", d.string)
  |> d.field("visibility", d.string)
  |> d.field("website", d.string)
}

pub fn decode_organization_list(
  json_string json_string: String,
) -> Result(List(Organization), json.DecodeError) {
  use data <- json.decode(json_string)
  d.list(organization_decoder())
  |> d.run(data)
}

pub fn decode_organization(
  json_string json_string: String,
) -> Result(Organization, json.DecodeError) {
  use data <- json.decode(json_string)
  organization_decoder()
  |> d.run(data)
}

pub type OrganizationPermissions {
  OrganizationPermissions(
    can_create_repository: Bool,
    can_read: Bool,
    can_write: Bool,
    is_admin: Bool,
    is_owner: Bool,
  )
}

pub type PRBranchInfo {
  PRBranchInfo(
    label: String,
    ref: String,
    repo: Repository,
    repo_id: Int,
    sha: String,
  )
}

pub type Package {
  Package(
    created_at: String,
    creator: User,
    html_url: String,
    id: Int,
    name: String,
    owner: User,
    repository: Repository,
    package_type: String,
    version: String,
  )
}

pub type PackageFile {
  PackageFile(
    size: Int,
    id: Int,
    md5: String,
    name: String,
    sha1: String,
    sha256: String,
    sha512: String,
  )
}

pub type PayloadCommit {
  PayloadCommit(
    added: List(String),
    author: PayloadUser,
    committer: PayloadUser,
    id: String,
    message: String,
    modified: List(String),
    removed: List(String),
    timestamp: String,
    url: String,
    verification: PayloadCommitVerification,
  )
}

pub type PayloadCommitVerification {
  PayloadCommitVerification(
    payload: String,
    reason: String,
    signature: String,
    signer: PayloadUser,
    verified: Bool,
  )
}

pub type PayloadUser {
  PayloadUser(email: String, name: String, username: String)
}

pub type Permission {
  Permission(admin: Bool, pull: Bool, push: Bool)
}

fn permission_decoder() -> d.Decoder(Permission) {
  d.into({
    use admin <- d.parameter
    use pull <- d.parameter
    use push <- d.parameter
    Permission(admin, pull, push)
  })
  |> d.field("admin", d.bool)
  |> d.field("pull", d.bool)
  |> d.field("push", d.bool)
}

pub type PublicKey {
  PublicKey(
    created_at: String,
    fingerprint: String,
    id: Int,
    key: String,
    key_type: String,
    read_only: Bool,
    title: String,
    url: String,
    user: User,
  )
}

fn public_key_decoder() -> d.Decoder(PublicKey) {
  d.into({
    use created_at <- d.parameter
    use fingerprint <- d.parameter
    use id <- d.parameter
    use key <- d.parameter
    use key_type <- d.parameter
    use read_only <- d.parameter
    use title <- d.parameter
    use url <- d.parameter
    use user <- d.parameter
    PublicKey(
      created_at,
      fingerprint,
      id,
      key,
      key_type,
      read_only,
      title,
      url,
      user,
    )
  })
  |> d.field("created_at", d.string)
  |> d.field("fingerprint", d.string)
  |> d.field("id", d.int)
  |> d.field("key", d.string)
  |> d.field("key_type", d.string)
  |> d.field("read_only", d.bool)
  |> d.field("title", d.string)
  |> d.field("url", d.string)
  |> d.field("user", user_decoder())
}

pub fn decode_public_key(
  json_string json_string: String,
) -> Result(PublicKey, json.DecodeError) {
  use data <- json.decode(json_string)
  public_key_decoder()
  |> d.run(data)
}

pub type PullRequest {
  PullRequest(
    allow_maintainer_edit: Bool,
    assignee: User,
    assignees: List(User),
    base: PRBranchInfo,
    body: String,
    closed_at: String,
    comments: Int,
    created_at: String,
    diff_url: String,
    due_date: String,
    head: PRBranchInfo,
    html_url: String,
    id: Int,
    is_locked: Bool,
    labels: List(Label),
    merge_base: String,
    merge_commit_sha: String,
    mergeable: Bool,
    merged: Bool,
    merged_at: String,
    merged_by: User,
    milestone: Milestone,
    number: Int,
    patch_url: String,
    pin_order: Int,
    requested_reviewers: List(User),
    state: StateType,
    title: String,
    updated_at: String,
    url: String,
    user: User,
  )
}

pub type PullRequestMeta {
  PullRequestMeta(draft: Bool, merged: Bool, merged_at: String)
}

pub type PullReview {
  PullReview(
    body: String,
    comments_count: Int,
    commit_id: String,
    dismissed: Bool,
    html_url: String,
    id: Int,
    official: Bool,
    pull_request_url: String,
    stale: Bool,
    state: ReviewStateType,
    submitted_at: String,
    team: Team,
    updated_at: String,
    user: User,
  )
}

pub type PullReviewComment {
  PullReviewComment(
    body: String,
    commit_id: String,
    created_at: String,
    diff_hunk: String,
    html_url: String,
    id: Int,
    original_commit_id: String,
    original_position: Int,
    path: String,
    position: Int,
    pull_request_review_id: Int,
    pull_request_url: String,
    resolver: User,
    updated_at: String,
    user: User,
  )
}

pub type PullReviewRequestOptions {
  PullReviewRequestOptions(
    reviewers: List(String),
    team_reviewers: List(String),
  )
}

pub type PushMirror {
  PushMirror(
    created: String,
    interval: String,
    last_error: String,
    last_update: String,
    remote_address: String,
    remote_name: String,
    repo_name: String,
    sync_on_commit: Bool,
  )
}

pub type Reaction {
  Reaction(content: String, created_at: String, user: User)
}

pub type Reference {
  Reference(object: GitObject, ref: String, url: String)
}

pub type Release {
  Release(
    assets: List(Attachment),
    author: User,
    body: String,
    created_at: String,
    draft: Bool,
    html_url: String,
    id: Int,
    name: String,
    prerelease: Bool,
    published_at: String,
    tag_name: String,
    tarball_url: String,
    target_commitish: String,
    upload_url: String,
    url: String,
    zipball_url: String,
  )
}

pub type RenameUserOption {
  RenameUserOption(new_username: String)
}

/// Encodes a [RenameUserOption](#RenameUserOption) into a Json string
/// 
pub fn encode_rename_user_option(
  user_option user_option: RenameUserOption,
) -> String {
  object([#("new_username", string(user_option.new_username))])
  |> json.to_string
}

pub type ReplaceFlagsOption {
  ReplaceFlagsOption(flags: List(String))
}

pub type RepoCollaboratorPermission {
  RepoCollaboratorPermission(permission: String, role_name: String, user: User)
}

pub type RepoCommit {
  RepoCommit(
    author: CommitUser,
    committer: CommitUser,
    message: String,
    tree: CommitMeta,
    url: String,
    verification: PayloadCommitVerification,
  )
}

pub type RepoTopicOptions {
  RepoTopicOptions(topics: List(String))
}

pub type RepoTransfer {
  RepoTransfer(doer: User, recipient: User, teams: List(Team))
}

fn repo_transfer_decoder() -> d.Decoder(RepoTransfer) {
  d.into({
    use doer <- d.parameter
    use recipient <- d.parameter
    use teams <- d.parameter
    RepoTransfer(doer, recipient, teams)
  })
  |> d.field("doer", user_decoder())
  |> d.field("recipient", user_decoder())
  |> d.field("teams", d.list(team_decoder()))
}

pub type Repository {
  Repository(
    allow_fast_forward_only_merge: Bool,
    allow_merge_commits: Bool,
    allow_rebase: Bool,
    allow_rebase_explicit: Bool,
    allow_rebase_update: Bool,
    allow_squash_merge: Bool,
    archived: Bool,
    archived_at: String,
    avatar_url: String,
    clone_url: String,
    created_at: String,
    default_allow_maintainer_edit: Bool,
    default_branch: String,
    default_delete_branch_after_merge: Bool,
    default_merge_style: String,
    description: String,
    empty: Bool,
    external_tracker: ExternalTracker,
    external_wiki: ExternalWiki,
    fork: Bool,
    forks_count: Int,
    full_name: String,
    has_actions: Bool,
    has_issues: Bool,
    has_packages: Bool,
    has_projects: Bool,
    has_pull_requests: Bool,
    has_releases: Bool,
    has_wiki: Bool,
    html_url: String,
    id: Int,
    ignore_whitespace_conflicts: Bool,
    internal: Bool,
    internal_tracker: InternalTracker,
    language: String,
    languages_url: String,
    link: String,
    mirror: Bool,
    mirror_interval: String,
    mirror_updated: String,
    name: String,
    object_format_name: ObjectFormat,
    open_issues_count: Int,
    open_pr_counter: Int,
    original_url: String,
    owner: User,
    parent: Option(Repository),
    permissions: Permission,
    private: Bool,
    release_counter: Int,
    repo_transfer: RepoTransfer,
    size: Int,
    ssh_url: String,
    stars_count: Int,
    template: Bool,
    updated_at: String,
    url: String,
    watchers_count: Int,
    website: String,
    wiki_branch: String,
  )
}

// FIXME: Probably infinitely recursive oops
fn repository_decoder() -> d.Decoder(Repository) {
  d.into({
    use allow_fast_forward_only_merge <- d.parameter
    use allow_merge_commits <- d.parameter
    use allow_rebase <- d.parameter
    use allow_rebase_explicit <- d.parameter
    use allow_rebase_update <- d.parameter
    use allow_squash_merge <- d.parameter
    use archived <- d.parameter
    use archived_at <- d.parameter
    use avatar_url <- d.parameter
    use clone_url <- d.parameter
    use created_at <- d.parameter
    use default_allow_maintainer_edit <- d.parameter
    use default_branch <- d.parameter
    use default_delete_branch_after_merge <- d.parameter
    use default_merge_style <- d.parameter
    use description <- d.parameter
    use empty <- d.parameter
    use external_tracker <- d.parameter
    use external_wiki <- d.parameter
    use fork <- d.parameter
    use forks_count <- d.parameter
    use full_name <- d.parameter
    use has_actions <- d.parameter
    use has_issues <- d.parameter
    use has_packages <- d.parameter
    use has_projects <- d.parameter
    use has_pull_requests <- d.parameter
    use has_releases <- d.parameter
    use has_wiki <- d.parameter
    use html_url <- d.parameter
    use id <- d.parameter
    use ignore_whitespace_conflicts <- d.parameter
    use internal <- d.parameter
    use internal_tracker <- d.parameter
    use language <- d.parameter
    use languages_url <- d.parameter
    use link <- d.parameter
    use mirror <- d.parameter
    use mirror_interval <- d.parameter
    use mirror_updated <- d.parameter
    use name <- d.parameter
    use object_format_name <- d.parameter
    use open_issues_count <- d.parameter
    use open_pr_counter <- d.parameter
    use original_url <- d.parameter
    use owner <- d.parameter
    use parent <- d.parameter
    use permissions <- d.parameter
    use private <- d.parameter
    use release_counter <- d.parameter
    use repo_transfer <- d.parameter
    use size <- d.parameter
    use ssh_url <- d.parameter
    use stars_count <- d.parameter
    use template <- d.parameter
    use updated_at <- d.parameter
    use url <- d.parameter
    use watchers_count <- d.parameter
    use website <- d.parameter
    use wiki_branch <- d.parameter
    Repository(
      allow_fast_forward_only_merge,
      allow_merge_commits,
      allow_rebase,
      allow_rebase_explicit,
      allow_rebase_update,
      allow_squash_merge,
      archived,
      archived_at,
      avatar_url,
      clone_url,
      created_at,
      default_allow_maintainer_edit,
      default_branch,
      default_delete_branch_after_merge,
      default_merge_style,
      description,
      empty,
      external_tracker,
      external_wiki,
      fork,
      forks_count,
      full_name,
      has_actions,
      has_issues,
      has_packages,
      has_projects,
      has_pull_requests,
      has_releases,
      has_wiki,
      html_url,
      id,
      ignore_whitespace_conflicts,
      internal,
      internal_tracker,
      language,
      languages_url,
      link,
      mirror,
      mirror_interval,
      mirror_updated,
      name,
      object_format_name |> object_format_from_string,
      open_issues_count,
      open_pr_counter,
      original_url,
      owner,
      parent,
      permissions,
      private,
      release_counter,
      repo_transfer,
      size,
      ssh_url,
      stars_count,
      template,
      updated_at,
      url,
      watchers_count,
      website,
      wiki_branch,
    )
  })
  |> d.field("allow_fast_forward_only_merge", d.bool)
  |> d.field("allow_merge_commits", d.bool)
  |> d.field("allow_rebase", d.bool)
  |> d.field("allow_rebase_explicit", d.bool)
  |> d.field("allow_rebase_update", d.bool)
  |> d.field("allow_squash_merge", d.bool)
  |> d.field("archived", d.bool)
  |> d.field("archived_at", d.string)
  |> d.field("avatar_url", d.string)
  |> d.field("clone_url", d.string)
  |> d.field("created_at", d.string)
  |> d.field("default_allow_maintainer_edit", d.bool)
  |> d.field("default_branch", d.string)
  |> d.field("default_delete_branch_after_merge", d.bool)
  |> d.field("default_merge_style", d.string)
  |> d.field("description", d.string)
  |> d.field("empty", d.bool)
  |> d.field("external_tracker", external_tracker_decoder())
  |> d.field("external_wiki", external_wiki_decoder())
  |> d.field("fork", d.bool)
  |> d.field("forks_count", d.int)
  |> d.field("full_name", d.string)
  |> d.field("has_actions", d.bool)
  |> d.field("has_issues", d.bool)
  |> d.field("has_packages", d.bool)
  |> d.field("has_projects", d.bool)
  |> d.field("has_pull_requests", d.bool)
  |> d.field("has_releases", d.bool)
  |> d.field("has_wiki", d.bool)
  |> d.field("html_url", d.string)
  |> d.field("id", d.int)
  |> d.field("ignore_whitespace_conflicts", d.bool)
  |> d.field("internal", d.bool)
  |> d.field("internal_tracker", internal_tracker_decoder())
  |> d.field("language", d.string)
  |> d.field("languages_url", d.string)
  |> d.field("link", d.string)
  |> d.field("mirror", d.bool)
  |> d.field("mirror_interval", d.string)
  |> d.field("mirror_updated", d.string)
  |> d.field("name", d.string)
  |> d.field("object_format_name", d.string)
  |> d.field("open_issues_count", d.int)
  |> d.field("open_pr_counter", d.int)
  |> d.field("original_url", d.string)
  |> d.field("owner", user_decoder())
  |> d.field("parent", d.optional(repository_decoder()))
  |> d.field("permissions", permission_decoder())
  |> d.field("private", d.bool)
  |> d.field("release_counter", d.int)
  |> d.field("repo_transfer", repo_transfer_decoder())
  |> d.field("size", d.int)
  |> d.field("ssh_url", d.string)
  |> d.field("stars_count", d.int)
  |> d.field("template", d.bool)
  |> d.field("updated_at", d.string)
  |> d.field("url", d.string)
  |> d.field("watchers_count", d.int)
  |> d.field("website", d.string)
  |> d.field("wiki_branch", d.string)
}

pub fn decode_repository_list(
  json_string json_string: String,
) -> Result(List(Repository), json.DecodeError) {
  use data <- json.decode(json_string)
  d.list(repository_decoder())
  |> d.run(data)
}

pub fn decode_repository(
  json_string json_string: String,
) -> Result(Repository, json.DecodeError) {
  use data <- json.decode(json_string)
  repository_decoder()
  |> d.run(data)
}

pub type RepositoryMeta {
  RepositoryMeta(full_name: String, id: Int, name: String, owner: String)
}

pub type ReviewStateType {
  ReviewStateType(String)
}

pub type SearchResults {
  SearchResults(data: List(Repository), ok: Bool)
}

pub type Secret {
  Secret(created_at: String, name: String)
}

pub type ServerVersion {
  ServerVersion(version: String)
}

pub type StateType {
  StateType(String)
}

pub type StopWatch {
  StopWatch(
    created: String,
    duration: String,
    issue_index: Int,
    issue_title: String,
    repo_name: String,
    repo_owner_name: String,
    seconds: Int,
  )
}

pub type SubmitPullReviewOptions {
  SubmitPullReviewOptions(body: String, event: ReviewStateType)
}

pub type Tag {
  Tag(
    commit: CommitMeta,
    id: String,
    message: String,
    name: String,
    tarball_url: String,
    zipball_url: String,
  )
}

pub type Team {
  Team(
    can_create_org_repo: Bool,
    description: String,
    id: Int,
    includes_all_repositories: Bool,
    name: String,
    organization: Organization,
    permission: TeamPermissions,
    units: List(String),
    units_map: List(#(String, String)),
  )
}

fn team_decoder() -> d.Decoder(Team) {
  d.into({
    use can_create_org_repo <- d.parameter
    use description <- d.parameter
    use id <- d.parameter
    use includes_all_repositories <- d.parameter
    use name <- d.parameter
    use organization <- d.parameter
    use permission <- d.parameter
    use units <- d.parameter
    use units_map <- d.parameter
    Team(
      can_create_org_repo,
      description,
      id,
      includes_all_repositories,
      name,
      organization,
      permission |> team_permissions_from_string,
      units,
      units_map,
    )
  })
  |> d.field("can_create_org_repo", d.bool)
  |> d.field("description", d.string)
  |> d.field("id", d.int)
  |> d.field("includes_all_repositories", d.bool)
  |> d.field("name", d.string)
  |> d.field("organization", organization_decoder())
  |> d.field("permission", d.string)
  |> d.field("units", d.list(d.string))
  |> d.field("units_map", d.list(d.tuple2(d.string, d.string)))
}

pub type TimeStamp {
  TimeStamp(Int)
}

pub type TimelineComment {
  TimelineComment(
    assignee: User,
    assignee_team: Team,
    body: String,
    created_at: String,
    dependent_issue: Issue,
    html_url: String,
    id: Int,
    issue_url: String,
    label: Label,
    milestone: Milestone,
    new_ref: String,
    new_title: String,
    old_milestone: Milestone,
    old_project_id: Int,
    old_ref: String,
    old_title: String,
    project_id: Int,
    pull_request_url: String,
    ref_action: String,
    ref_comment: Comment,
    ref_commit_sha: String,
    ref_issue: Issue,
    removed_assignee: Bool,
    resolve_doer: User,
    review_id: Int,
    tracked_time: TrackedTime,
    timeline_comment_type: String,
    updated_at: String,
    user: User,
  )
}

pub type TopicName {
  TopicName(topics: List(String))
}

pub type TopicResponse {
  TopicResponse(
    created: String,
    id: Int,
    repo_count: Int,
    topic_name: String,
    updated: String,
  )
}

pub type TrackedTime {
  TrackedTime(
    created: String,
    id: Int,
    issue: Issue,
    issue_id: Int,
    time: Int,
    user_id: Int,
    user_name: String,
  )
}

pub type TransferRepoOption {
  TransferRepoOption(new_owner: String, team_ids: List(Int))
}

pub type UpdateFileOptions {
  UpdateFileOptions(
    author: Option(Identity),
    branch: Option(String),
    commiter: Option(Identity),
    content: String,
    dates: CommitDateOptions,
    from_path: Option(String),
    message: Option(String),
    new_branch: Option(String),
    sha: String,
    signoff: Bool,
  )
}

pub type UpdateRepoAvatarOption {
  UpdateRepoAvatarOption(image: String)
}

pub type UpdateUserAvatarOption {
  UpdateUserAvatarOption(image: String)
}

pub type User {
  User(
    active: Bool,
    avatar_url: String,
    created: String,
    description: String,
    email: String,
    followers_count: Int,
    following_count: Int,
    full_name: String,
    id: Int,
    is_admin: Bool,
    language: String,
    last_login: String,
    location: String,
    login: String,
    login_name: String,
    prohibit_login: Bool,
    pronouns: String,
    restricted: Bool,
    starred_repos_count: Int,
    visibility: String,
    website: String,
  )
}

fn user_decoder() -> d.Decoder(User) {
  d.into({
    use active <- d.parameter
    use avatar_url <- d.parameter
    use created <- d.parameter
    use description <- d.parameter
    use email <- d.parameter
    use followers_count <- d.parameter
    use following_count <- d.parameter
    use full_name <- d.parameter
    use id <- d.parameter
    use is_admin <- d.parameter
    use language <- d.parameter
    use last_login <- d.parameter
    use location <- d.parameter
    use login <- d.parameter
    use login_name <- d.parameter
    use prohibit_login <- d.parameter
    use pronouns <- d.parameter
    use restricted <- d.parameter
    use starred_repos_count <- d.parameter
    use visibility <- d.parameter
    use website <- d.parameter
    User(
      active,
      avatar_url,
      created,
      description,
      email,
      followers_count,
      following_count,
      full_name,
      id,
      is_admin,
      language,
      last_login,
      location,
      login,
      login_name,
      prohibit_login,
      pronouns,
      restricted,
      starred_repos_count,
      visibility,
      website,
    )
  })
  |> d.field("active", d.bool)
  |> d.field("avatar_url", d.string)
  |> d.field("created", d.string)
  |> d.field("description", d.string)
  |> d.field("email", d.string)
  |> d.field("followers_count", d.int)
  |> d.field("following_count", d.int)
  |> d.field("full_name", d.string)
  |> d.field("id", d.int)
  |> d.field("is_admin", d.bool)
  |> d.field("language", d.string)
  |> d.field("last_login", d.string)
  |> d.field("location", d.string)
  |> d.field("login", d.string)
  |> d.field("login_name", d.string)
  |> d.field("prohibit_login", d.bool)
  |> d.field("pronouns", d.string)
  |> d.field("restricted", d.bool)
  |> d.field("starred_repos_count", d.int)
  |> d.field("visibility", d.string)
  |> d.field("website", d.string)
}

pub fn decode_user(
  json_string json_string: String,
) -> Result(User, json.DecodeError) {
  use data <- json.decode(json_string)
  user_decoder()
  |> d.run(data)
}

pub fn decode_user_list(
  json_string json_string: String,
) -> Result(List(User), json.DecodeError) {
  use data <- json.decode(json_string)
  d.list(user_decoder())
  |> d.run(data)
}

pub type UserHeatmapData {
  UserHeatmapData(contributions: Int, timestamp: TimeStamp)
}

pub type UserSettings {
  UserSettings(
    description: String,
    diff_view_style: String,
    enable_repo_unit_hints: Bool,
    full_name: String,
    hide_activity: Bool,
    hide_email: Bool,
    language: String,
    location: String,
    pronouns: String,
    theme: String,
    website: String,
  )
}

pub type UserSettingsOptions {
  UserSettingsOptions(
    description: String,
    diff_view_style: String,
    enable_repo_unit_hints: Bool,
    full_name: String,
    hide_activity: Bool,
    hide_email: Bool,
    language: String,
    location: String,
    pronouns: String,
    theme: String,
    website: String,
  )
}

pub type WatchInfo {
  WatchInfo(
    created_at: String,
    ignored: Bool,
    reason: Dynamic,
    respository_url: String,
    subscribed: Bool,
    url: String,
  )
}

pub type WikiCommit {
  WikiCommit(
    author: CommitUser,
    committer: CommitUser,
    message: String,
    sha: String,
  )
}

pub type WikiCommitList {
  WikiCommitList(commits: List(WikiCommit), count: Int)
}

pub type WikiPage {
  WikiPage(
    commit_count: Int,
    content_base64: String,
    footer: String,
    html_url: String,
    last_commit: WikiCommit,
    sidebar: String,
    sub_url: String,
    title: String,
  )
}

pub type WikiPageMetaData {
  WikiPageMetaData(
    html_url: String,
    last_commit: WikiCommit,
    sub_url: String,
    title: String,
  )
}
