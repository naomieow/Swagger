//// Models, decoders and encoders
//// 

import gleam/option.{type Option}
import gleam/dynamic.{type Dynamic}

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

pub type ObjectFormat {
  Sha1
  Sha256
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

pub type Email {
  Email(
    email: String,
    primary: Bool,
    user_id: Int,
    username: String,
    verified: Bool,
  )
}

pub type ExternalTrackerStyle {
  Numeric
  Alphanumeric
  Regexp
}

pub type ExternalTracker {
  ExternalTracker(
    external_tracker_format: String,
    external_tracker_regexp_pattern: String,
    external_tracker_style: ExternalTrackerStyle,
    external_tracker_url: String,
  )
}

pub type ExternalWiki {
  ExternalWiki(external_wiki_url: String)
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
