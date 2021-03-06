﻿
 param (
    [Parameter(Mandatory=$true)]
    [string]$testSettings,

    [switch]$doc = $false
 )

$visualStudioVersion = $env:VisualStudioVersion
$pythonPath = "stone"
$nugetUrl = "http://dist.nuget.org/win-x86-commandline/latest/nuget.exe"
$solutionDir = Resolve-Path "dropbox-sdk-dotnet"
$generatorDir = Resolve-Path "generator"
$sourceDir = "$solutionDir\Dropbox.Api"
$testsDir = "$solutionDir\Dropbox.Api.Tests"
$specDir = Resolve-Path "spec"
$nugetDir = "$solutionDir\.nuget"
$nugetPath = "$nugetDir\nuget.exe"
$nugetSpecPath = "$sourceDir\Dropbox.Api.nuspec"
$docBuildPath = Resolve-Path "doc\StoneDocs.shfbproj"
$majorVersion = "4.0"
$releaseVersion = "4.10.0"
$assemblyInfoPath = "$sourceDir\AppProperties\AssemblyInfo.cs"
$signKeyPath = "$sourceDir\dropbox_api_key.snk"
$releaseNotes = @'
Change Notes:
(cfd31ba4ca1af7b82e3e6a35fae5ecf825584598)
Account namespace:
	- Added set_profile_photo end point.

Auth namespace:
	- Added route_access_denied to AuthError.

Common namespace:
	- Added SecondaryEmail struct.

Contacts namespace:
	- Added scope route attribute to delete_manual_contacts end point.

Files namespace:
	- Added scope route attribute to the following end points:
		- get_metadata
		- list_folder/longpoll
		- list_folder
		- list_folder/continue
		- list_folder/get_latest_cursor
		- download
		- download_zip
		- export
		- upload_session/start
		- upload_session/append
		- upload_session/append:2
		- upload_session/finish
		- upload_session/finish_batch
		- upload_session/finish_batch/check
		- search
		- upload
		- create_folder
		- create_folder:2
		- create_folder_batch
		- create_folder_batch/check
		- delete
		- delete:2
		- delete_batch
		- delete_batch/check
		- permanently_delete
		- copy
		- copy:2
		- copy_batch
		- copy_batch:2
		- copy_batch/check
		-  copy_batch/check:2
		- move
		- move:2
		- move_batch
		- move_batch:2
		- move_batch/check:2
		- move_batch/check
		- get_thumbnail
		- get_thumbnail_batch
		- get_preview
		- list_revisions
		- restore
		- get_temporary_link
		- get_temporary_upload_link
		- copy_reference/get
		- copy_reference/save
		- save_url
		- save_url/check_job_status
	- Added new search:2 end point.
	- Added new search/continue:2 end point
	- Added new lock_file_batch end point
	- Added new unlock_file_batch end point
	- Added new get_file_lock_batch end point
	- Added New MetadataV2 union
	- Added new HighlightSpan struct
	- Added new FileLockMetadata struct
	- Added file_lock_info to FileMetadata struct
	- Added template_error to ListFolderError union
	- Added retry_error to ExportError union

File_properties namespace:
	- Added scope route attribute to to the following end points:
		- properties/add
		- properties/overwrite
		- properties/update
		- properties/remove
		- properties/search
		- templates/add_for_user
		- templates/add_for_team
		- templates/get_for_user
		- templates/get_for_team
		- templates/update_for_user
		- templates/update_for_team
		- templates/list_for_user
		- templates/list_for_team
		- templates/remove_for_user
		- templates/remove_for_team

File_requests namespace:
	- Added optional scope route attribute to to the following end points:
		- list:2
		- list/continue
		- list
		- get
		- create
		- update
		- count
		- delete
		- delete_all_closed
	- Updated docstrings for CreateFileRequestError

Team namespace:
	-  Added scope route attribute to to the following end points:
		-  legal_holds/release_policy
		-  members/secondary_emails/add
		-  members/secondary_emails
		- get_info
		- token/get_authenticated_admin
		- features/get_values
		- devices/list_member_devices
		- devices/list_members_devices
		- devices/revoke_device_session
		- devices/revoke_device_session_batch
		- team_folder/create
		- team_folder/rename
		- team_folder/list
		- team_folder/list/continue
		- team_folder/get_info
		- team_folder/activate
		- team_folder/archive
		- team_folder/archive/check
		- team_folder/permanently_delete
		- groups/list
		- groups/list/continue
		- groups/get_info
		- groups/create
		- groups/delete
		- groups/update
		- groups/members/add
		- groups/members/remove
		- groups/members/set_access_type
		- groups/members/list
		- groups/members/list/continue
		- linked_apps/list_member_linked_apps
		- linked_apps/list_members_linked_apps
		- linked_apps/revoke_linked_app
		- linked_apps/revoke_linked_app_batch
		- member_space_limits/set_custom_quota
		- member_space_limits/remove_custom_quota
		- member_space_limits/get_custom_quota
		- member_space_limits/excluded_users/add
		- member_space_limits/excluded_users/remove
		- member_space_limits/excluded_users/list
		- members/list
		- members/list/continue
		- members/get_info
		- members/add
		- members/add/job_status/get
		- members/set_admin_permissions
		- members/send_welcome_email
		- members/remove
		- members/remove/job_status/get
		- members/suspend
		- members/unsuspend
		- members/recover
		- members/move_former_member_files
		- namespaces/list
		- namespaces/list/continue
		- reports/get_storage
		- reports/get_activity
		- reports/get_membership

	- Added new legal_holds/release_policy end point.
	- Added new members/secondary_emails/add end point.
	- Added new members/secondary_emails/resend_verification_emails
	- Added new members/secondary_emails/delete end point
	- Added new members/set_profile_photo end point
	- Added new members/delete_profile_photo end point
	- Added secondary_emails to MemberProfile struct
	- Added invited_on to MemberProfile struct
	- Added retain_team_shares in MembersRemoveArg Struct
	- Added the following to MembersRemoveError union
		- cannot_retain_shares_when_data_wiped
		- cannot_retain_shares_when_no_account_kept
		- cannot_retain_shares_when_team_external_sharing_off
		- cannot_keep_account
		- cannot_keep_account_under_legal_hold
		- cannot_keep_account_required_to_sign_tos
	- Updated docstring for DateRange

Team_log namespace:
	- Add scope route attribute to the following end points:
		- get_events
	- Added unlink_device to QuickActionType union
	- Added enterprise_console to AccessMethodLogInfo
	- Added was_linked_apps_truncated, was_linked_devices_truncated
, was_linked_shared_folders_truncated to JoinTeamDetails struct
	- Added web_session, qr_code, apple_oauth to LoginMethod union
	- Added enterprise_admin to TrustedNonTeamMemberType union
	- Added team to TeamMemberLogInfo struct
	- Added is_shared_namespace to NamespaceRelativePathLogInfo struct
	- Added organization_team to ContextLogInfo union
	- Added legal_holds to EventCategory union
	- Added the following to EventDetails union:
		- folder_overview_description_changed_details
		- folder_overview_item_pinned_details
		- folder_overview_item_unpinned_details
		- legal_holds_activate_a_hold_details
		- legal_holds_add_members_details
		- legal_holds_change_hold_details_details
		- legal_holds_change_hold_name_details
		- legal_holds_export_a_hold_details
		- legal_holds_release_a_hold_details
		- legal_holds_remove_members_details
		- legal_holds_report_a_hold_details
		- member_delete_profile_photo_details
		- member_set_profile_photo_details
		- pending_secondary_email_added_details
		- secondary_email_deleted_details
		- secondary_email_verified_details
		- paper_published_link_change_permission_details
		- export_members_report_fail_details
		- file_transfers_file_add_details
		- file_transfers_transfer_delete_details
		- file_transfers_transfer_download_details
		- file_transfers_transfer_send_details
		- file_transfers_transfer_view_details
		- shared_content_restore_invitees_details
		- shared_content_restore_member_details
		- device_approvals_add_exception_details
		- device_approvals_remove_exception_details
		- file_locking_policy_changed_details
		- file_transfers_policy_changed_details
		- password_strength_requirements_change_policy_details
		- smarter_smart_sync_policy_changed_details
		- tfa_add_exception_details
		- tfa_remove_exception_details
		- watermarking_policy_changed_details
		- changed_enterprise_admin_role_details
		- changed_enterprise_connected_team_status_details
		- ended_enterprise_admin_session_details
		- ended_enterprise_admin_session_deprecated_details
		- started_enterprise_admin_session_details
	- Added the following to EventType union:
		- folder_overview_description_changed
		- folder_overview_item_pinned
		- folder_overview_item_unpinned
		- legal_holds_activate_a_hold
		- legal_holds_add_members
		- legal_holds_change_hold_details
		- legal_holds_change_hold_name
		- legal_holds_export_a_hold
		- legal_holds_release_a_hold
		- legal_holds_remove_members
		- legal_holds_report_a_hold
		- member_delete_profile_photo
		- member_set_profile_photo
		- pending_secondary_email_added
		- secondary_email_deleted
		- secondary_email_verified
		- paper_published_link_change_permission
		- export_members_report_fail
		- file_transfers_file_add
		- file_transfers_transfer_delete
		- file_transfers_transfer_download
		- file_transfers_transfer_send
		- file_transfers_transfer_view
		- shared_content_restore_invitees
		- shared_content_restore_member
		- device_approvals_add_exception
		- device_approvals_remove_exception
		- file_locking_policy_changed
		- file_transfers_policy_changed
		- password_strength_requirements_change_policy
		- smarter_smart_sync_policy_changed
		- tfa_add_exception
		- tfa_remove_exception
		- watermarking_policy_changed
		- changed_enterprise_admin_role
		- changed_enterprise_connected_team_status
		- ended_enterprise_admin_session
		- ended_enterprise_admin_session_deprecated
		- started_enterprise_admin_session

Team_policies namespace:
	- Added disabled in TwoStepVerificationState union
	- Added new unions PasswordControlMode, SmarterSmartSyncPolicyState
, FileLockingPolicyState

Paper namespace:
	- Updated doctoring for the namespace
	- Updated doctoring for PaperApiBaseError
	- Added PaperFolderCreateArg, PaperFolderCreateResult structs
	- Added new PaperFolderCreateError union
	- Updated docstring for following end points:
		- docs/folder_users/list
		- docs/folder_users/list/continue
		- docs/sharing_policy/get
		- docs/sharing_policy/set
		- docs/archive
		- docs/permanently_delete
		- docs/download
		- docs/get_folder_info
		- docs/users/add
		- docs/users/remove
		- docs/users/list
		- docs/users/list/continue
		- docs/list
		- docs/list/continue
		- docs/create
		- docs/update
		- folders/create
	-  Added scope route attribute to the following end points:
		- docs/folder_users/list
		- docs/folder_users/list/continue
		- docs/sharing_policy/get
		- docs/sharing_policy/set
		- docs/archive
		- docs/permanently_delete
		- docs/download
		- docs/get_folder_info
		- docs/users/add
		- docs/users/remove
		- docs/users/list
		- docs/users/list/continue
		- docs/list
		- docs/list/continue
		- docs/create
		- docs/update

Sharing namespace:
	 Add scope route attribute to the following end points:
		- get_shared_link_metadata
		- list_shared_links
		- modify_shared_link_settings
		- create_shared_link_with_settings
		- revoke_shared_link
		- get_shared_link_file
		- add_file_member
		- update_file_member
		- get_file_metadata
		- get_file_metadata/batch
		- list_file_members
		- list_file_members/batch
		- list_file_members/continue
		- list_received_files
		- list_received_files/continue
		- remove_file_member
		- remove_file_member_2
		- relinquish_file_membership
		- unsharp_file
		- list_folders
		- list_folders/continue
		- list_mountable_folders
		- list_mountable_folders/continue
		- get_folder_metadata
		- list_folder_members
		- list_folder_members/continue
		- share_folder
		- check_share_job_status
		- check_job_status
		- unsharp_folder
		- transfer_folder
		- update_folder_policy
		- add_folder_member
		- remove_folder_member
		- check_remove_member_job_status
		- update_folder_member
		- mount_folder
		- unmount_folder
		- relinquish_folder_membership
		- set_access_inheritance

	- Add parent_folder_name to SharedFolderMetadataBase

	Users namespace:
		- Added scope route attribute to the following end points:
			- get_account
			- get_current_account
			- get_space_usage
			- get_account_batch
		- Added user_within_team_space_used_cached to TeamSpaceAllocation struct
		- Added new features/get_values end point

(fbc2f1e2063ed4aed4ced6df53f1f3d3c6755491)

Check namespace:
	- Added this namespace for authentication test
Team_log namespace:
	- Added notification_type to AccountCaptureNotificationEmailsSentDetails
	- Added the following to EventDetails union
		- shared_link_settings_add_expiration_details
		- shared_link_settings_add_password_details
		- shared_link_settings_allow_download_disabled_details
		- shared_link_settings_allow_download_enabled_details
		- shared_link_settings_change_audience_details
		- shared_link_settings_change_expiration_details
		- shared_link_settings_change_password_details
		- shared_link_settings_remove_expiration_details
		- shared_link_settings_remove_password_details

(be4e7c5b2c2b1af9ff2e8ee2416371fdc54b38b2)

Files Namespace:
	- Update comments on FileLockMetadata struct
	- Add optional lockholder_account_id to FileLockMetadata struct
	- Add optional invalid_argument to SearchError union

	- Add get_thumbnail:2 route

	- Add ThumbnailV2Error union
	- Add MinimalFileLinkMetadata struct
	- Add PreviewResult struct
	- Add SharedLinkFileInfo struct
	- Add PathOrLink union
	- Add ThumbnailV2Arg struct

	- Change UnlockFileArg's path type to WritePathOrId
	- Change LockFileArg's path type to WritePathOrId

Shared Links Namespace:
	- Fix Typo

Team Groups Namespace:
	- Add add_creator_as_owner to GroupCreateArg struct
	- Update comments for async_job_id on GroupMembersChangeResult struct

Team Legal Holds Namespace:
	- Add exporting to LegalHoldStatus union
	- Add invactive_legal_hold to LegalHoldsListHeldRevisionsError union
	- Add legal_hold_policy_not_found to LegalHoldsPolicyUpdateError union

	- Add MembersInfo struct
	- Add LegalHoldsError union

	- mark legal_holds/export_policy to deprecated
	- mark legal_holds/export_policy_job_status/check to deprecated

	- Change LegalHoldPolicy's members type to MembersInfo
	- Update LegalHoldPolicy's examples
	- Update LegalHoldsPolicyCreateError to extend LegalHoldsError
	- Update LegalHoldsGetPolicyError to extend LegalHoldsError
	- Update LegalHoldsListPoliciesError to extend LegalHoldsError
	- Update LegalHoldsPolicyUpdateError to extend LegalHoldsError

Team Log Namespace:
	- Remove lifespan comment

Team Log Generated Namesapce:
	- Add team_invite_details to ActionDetails union
	- Add optional has_linked_apps to JoinTeamDetails struct
	- Add optional has_linked_devices to JoinTeamDetails struct
	- Add optional has_linkeD_shared_folders to JoinTeamDetails struct
	- Update comments in JoinTeamDetails struct
	- Update JoinTeamDetails struct examples
	- Update LegalHoldsExportAHoldDetails struct examples
	- Update PaperContentRemoveFromFolderDetails target_asset_index to be optional
	- Update PaperContentRemoveFromFolderDetails parent_asset_index to be optional
	- Add shared_content_link to SharedLinkSettingsAddExpirationDetails struct
	- Update SharedLinkSettingAddExpirationDetails struct examples
	- Add optional shared_content_link to SharedLinkSettingsAddPasswordDetails struct
	- Add optional shared_content_link to SharedLinkSettingsAllowDownloadDisabledDetails struct
	- Add optional shared_content_link to SharedLinkSettingsAllowDownloadEnabledDetails struct
	- Add optional shared_content_link to SharedLinkSettingsChangeAudienceDetails struct
	- Add optional shared_content_link to SharedLinkSettingsChangeExpirationDetails struct
	- Add optional shared_content_link to SharedLinkSettingsChangePasswordDetails struct
	- Add optional shared_content_link to SharedLinkSettingsRemoveExpirationDetails struct
	- Add optional shared_content_link to SharedLinkSettingsRemovePasswordDetails struct
	- Add file_locking_status_changed_details to EventDetails union
	- Add rewind_folder_details to EventDetails union
	- Add legal_holds_export_cancelled_details to EventDetails union
	- Add legal_holds_export_downloaded_details to EventDetails union
	- Add legal_holds_export_removed_details to EventDetails union
	- Add create_team_invite_link_details to EventDetails union
	- Add delete_team_invite_link_details to EventDetails union
	- Add binder_add_page_details to EventDetails union
	- Add binder_add_section_details to EventDetails union
	- Add binder_remove_page_details to EventDetails union
	- Add binder_remove_section_details to EventDetails union
	- Add binder_rename_page_details to EventDetails union
	- Add binder_rename_section_details to EventDetails union
	- Add binder_reorder_page_details to EventDetails union
	- Add binder_reorder_section_details to EventDetails union
	- Add rewind_policy_changed_details to EventDetails union
	- Add team_sharing_whitelist_subjects_changed_details to EventDetails union
	- Add web_sessions_change_active_session_limit_details to EventDetails union
	- Add enterprise_settings_locking_details to EventDetails union
	- Add file_locking_lock_status_changed to EventType union
	- Add rewind_folder to EventType union
	- Add legal_holds_export_cancelled to EventType union
	- Add legal_holds_export_downloaded to EventType union
	- Add legal_holds_export_removed to EventType union
	- Add create_team_invite_link to EventType union
	- Add delete_team_invite_link to EventType union
	- Add binder_add_page to EventType union
	- Add binder_add_section to EventType union
	- Add binder_remove_page to EventType union
	- Add binder_remove_section to EventType union
	- Add binder_rename_page to EventType union
	- Add binder_rename_section to EventType union
	- Add binder_reorder_page to EventType union
	- Add binder_reorder_section to EventType union
	- Add rewind_policy_changed to EventType union
	- Add team_sharing_whitelist_subjects_changed to EventType union
	- Add web_sessions_change_active_session_limit to EventType union
	- Add enterprise_settings_locking to EventType union

	- Add TeamInviteDetails struct
	- Add InviteMethod union
	- Add LockStatus union
	- Add RewindPolicy union
	- Add FileLockingLockStatusChangedDetails struct
	- Add RewindFolderDetails struct
	- Add LegalHoldsExportCancelledDetails struct
	- Add LegalHoldsExportDownloadedDetails struct
	- Add LegalHoldsExportRemovedDetails struct
	- Add CreateTeamInviteLinkDetails struct
	- Add DeleteTeamInviteLinkDetails struct
	- Add BinderAddPageDetails struct
	- Add BinderAddSectionDetails struct
	- Add BinderRemovePageDetails struct
	- Add BinderRemoveSectionDetails struct
	- Add BinderRenamePageDetails struct
	- Add BinderRenameSectionDetails struct
	- Add BinderReorderPageDetails struct
	- Add BinderReorderSectionDetails struct
	- Add RewindPolicyChangedDetails struct
	- Add TeamSharingWhitelistSubjectsChangedDetails struct
	- Add WebSessionsChangeActiviteSessionLimitDetails struct
	- Add EnterpriseSettingsLockingDetails struct
	- Add FileLockingLockStatusChangedType struct
	- Add RewindFolderType struct
	- Add LegalHoldsExportCancelledType struct
	- Add LegalHoldsExportDownloadedType struct
	- Add LegalHoldsExportRemovedType struct
	- Add CreateTeamInviteLinkType struct
	- Add DeleteTeamInviteLinkType struct
	- Add BinderAddPageType struct
	- Add BinderAddSectionType struct
	- Add BinderRemovePageType struct
	- Add BinderRemoveSectionType struct
	- Add BinderRenamePageType struct
	- Add BinderRenameSectionType struct
	- Add BinderReorderPageType struct
	- Add BinderReorderSectionType struct
	- Add RewindPolicyChangedType struct
	- Add TeamSharingWhitelistSubjectsChangedType struct
	- Add WebSessionsChangeActiveSessionLimitType struct
	- Add EnterpriseSettingsLockingType struct

Users Namespace:
	- Add file_locking to UserFeature union
	- Add file_locking to UserFeatureValue
	- Update example for UserFeaturesGetaluesBatchArg

	- Add FileLockingValue union

(8c7f9ae52038c8067a5fc692dd9307a3503a5297)

Stone configuration

- added a new route property is_cloud_doc_auth indicating whether the endpoint is a Dropbox cloud docs endpoint which takes cloud docs auth token.
Files namespace

- lock_file_batch, unlock_file_batch and get_file_lock_batch are no longer preview routes
Team namespace

- Deleted deprecated routes legal_holds/export_policy and legal_holds/export_policy_job_status/check
Team_log namespace:

- Added AccountState union
- Added AccountLockOrUnlockedType struct
- Added AccountLockOrUnlockedDetails struct
- Added MemberSendInvitePolicy union
- Added MemberSendInvitePolicyChangedType struct
- Added MemberSendInvitePolicyChangedDetails struct
- Added a new tag first_party_token_exchange to LoginMethod union
- Added new tags account_lock_or_unlocked_details and member_send_invite_policy_changed_details to EventDetails union
- Added new tags account_lock_or_unlocked and member_send_invite_policy_changed to EventType union
- Added a new field file_size to FileOrFolderLogInfo and FileLogInfo struct
- Added a new field file_count to FolderLogInfo struct

(2aac6c8d3313b3c49b27847b0ec6eb457d113fca)

Cloud Docs Namespace

- Add get_content, get_metadata, rename, unlock, and lock routes
- Add corresponding args, results, and errors

File Properties Namespace

- Update AddPropertiesArg description
- Add duplicate_property_groups to InvalidPropertyGroupError Union
- Update property_groups description on AddPropertiesError Union

Files Namespace

- Update query description on SearchArg Struct, SearchV2Arg Struct
- Update move:2 and move_batch:2 route descirption

Shared Links Namespace

- Update SharedLinkSettings example

Stone CFG Namespace

- Update auth type string patterns
- Update host string patterns
- Update style string patterns
- Update select_admin_mode string patterns

Team Legal Holds Namespace

- Add team_exceeded_legal_hold_quota to LegalHoldsPolicyCreateError union
- Change LegalHoldsListHeldRevisionsError and LegalHoldsPolicyReleaseError to extend LegalHoldsError

Team Log Generated Namespace

- Add NoExpirationLinkGenCreateReportDetails, NoExpirationLinkGenReportFailedDetails, NoPasswordLinkGenCreateReportDetails, NoPasswordLinkGenReportFailedDetails, NoPasswordLinkViewCreateReportDetails, NoPasswordLinkViewReportFailedDetails, OutdatedLinkViewCreateReportDetails, OutdatedLnkViewReportFailedDetails structs to the EventDetails union
- Add NoExpirationLinkGenCreateReportType, NoExpirationLinkGenReportFailedType, NoPasswordLinkGenCreateReportType, NoPasswordLinkGenReportFailedType, NoPasswordLinkViewCreateReportType, NoPasswordLinkViewReportFailedType, OutdatedLinkViewCreateReportType, OutdatedLinkViewReportFailedType structs to the EventType union

Team Secondary Mails Namespace:

- Remove is_preview from route add, resend_verification_emails, and delete
'@

$builds = @(
    @{Name = "Dropbox.Api"; Configuration="Release"; SignAssembly=$true; TestsName="Dropbox.Api.Tests"},
    @{Name = "Dropbox.Api.Portable"; Configuration="Release"; SignAssembly=$true; TestName=$null},
    @{Name = "Dropbox.Api.Portable40"; Configuration="Release"; SignAssembly=$true; TestName=$null},
    @{Name = "Dropbox.Api.NetStandard"; Configuration="Release"; SignAssembly=$true; TestName=$null},
    @{Name = "Dropbox.Api.Doc"; Configuration="Release"; SignAssembly=$false; TestName=$null}
)

function RunCommand($command)
{
    return & $command
}

function EnsureVisualStudioVersion()
{
    Write-Host "Checking Visual Studio version..."
    if (!($visualStudioVersion -ge 12))
    {
        Write-Error "This requires a visual studio version 12.0 ""VS2013"" to be installed." -ErrorAction SilentlyContinue
        Write-Error "Did you run vcvarsall.bat?" -ErrorAction Stop
    }
}

function EnsureNuGetExists()
{
  Write-Host "Checking nuget.exe..."
  if (!(Test-Path $nugetPath))
  {
    Write-Host "Couldn't find nuget.exe. Downloading from $nugetUrl to $nugetPath"

    if (!(Test-Path $nugetDir))
    {
        New-Item $nugetDir -ItemType Directory
    }

    (New-Object System.Net.WebClient).DownloadFile($nugetUrl, $nugetPath)
  }
}

function EnsurePythonExists()
{
    Write-Host "Checking Python environment..."
    if (!(Get-Command "python" -ErrorAction SilentlyContinue)) {
        Write-Error "Cannot find python.exe, do you need to check your path?" -ErrorAction Stop
    }
}

function EnsurePipExists()
{
    Write-Host "Checking pip..."
    if (!(Get-Command "pip" -ErrorAction SilentlyContinue)) {
        Write-Error "Cannot find pip.exe, do you need to check your path?" -ErrorAction Stop
    }
}

function InstallStoneDependency()
{
    RunCommand { pip "install" "ply>=3.4" "six>=1.3.0" "typing>=3.5.2" }
}

function GenerateProjectFiles()
{
    Write-Host "Generating Dropbox.Api..."

    [environment]::SetEnvironmentVariable("PYTHONPATH", $pythonPath)

    RunCommand { python 'generate.py' }
}

function RestoreNugetPackages()
{
    Write-Host "Restoring nuget packages..."
    RunCommand  { & $nugetPath restore "$solutionDir\Dropbox.Api.sln" }
}

function RunMSBuild()
{
    param (
        [string] $buildPath,
        [string] $config = "Debug",
        [switch] $signAssembly = $false
    )

    RunCommand { msbuild "/t:Clean;Rebuild" "/verbosity:minimal" "/clp:ErrorsOnly" "/m" $buildPath "/p:Configuration=$config"  "/p:AssemblyOriginatorKeyFile=$signKeyPath" "/p:SignAssembly=$signAssembly"}
}

function BuildPackage($build)
{
    $name = $build.Name
    $config = $build.Configuration
    $testsName = $build.TestsName
    $signAssembly = $build.SignAssembly

    Write-Host "Building $name..."
    RunMSBuild "$sourceDir\$name.csproj" $config -signAssembly $signAssembly

    if ($testsName -ne $null)
    {
        RunVSUnitTests $testsName
    }
}

function BuildPackages()
{
    foreach ($build in $builds)
    {
        BuildPackage $build
    }
}

function RunVSUnitTests($testsName)
{
    Write-Host "Building $testsName..."
    RunMSBuild "$testsDir/$testsName.csproj"
    Write-Host "Running tests $testName..."
    RunCommand { vstest.console "$testsDir\bin\Debug\$testsName.dll" "/Settings:$testSettings" }
}

function BuildDoc()
{
    if ($doc)
    {
        Write-Host "Building Doc..."
        RunMSBuild $docBuildPath
    }
}

function PackNugetPackage()
{
    Write-Host "Packing Nuget package..."
    RunCommand { & $nugetPath pack $nugetSpecPath }
}

function GetAssemblyFileVersion($majorVersion)
{
    $date = Get-Date
    $start = [datetime]"01/01/2000"
    $span = New-TimeSpan -Start $start -End $date
    $minor = [int]($span.TotalDays)

    return "$majorVersion.$minor"

}

function GetAssemblyVersion($majorVersion)
{
    return "$majorVersion.0"
}

function UpdateAssemblyInfo()
{
    $assemblyVersionNumber = GetAssemblyVersion $majorVersion
    $fileVersionNumber = GetAssemblyFileVersion $majorVersion
    Write-Host $fileVersionNumber
    $assemblyVersionPattern = 'AssemblyVersion\(.*\)'
    $fileVersionPattern = 'AssemblyFileVersion\(.*\)'
    $assemblyVersion = 'AssemblyVersion("' + $assemblyVersionNumber + '")';
    $fileVersion = 'AssemblyFileVersion("' + $fileVersionNumber + '")';

    Write-Host "Updating AssemblyInfo.cs..."
    (Get-Content $assemblyInfoPath) | ForEach-Object {
        % {$_ -replace $assemblyVersionPattern, $assemblyVersion } |
        % {$_ -replace $fileVersionPattern, $fileVersion }
    } | Set-Content $assemblyInfoPath
}

function UpdateNugetSpec()
{
    Write-Host "Updating nuspec file..."
    $xml = [xml](Get-Content $nugetSpecPath)
    $xml.SelectNodes('/package/metadata/version')[0].InnerXml = $releaseVersion
    $xml.SelectNodes('/package/metadata/releaseNotes')[0].InnerXml = "`n" + $releaseNotes + "`n    "
    $xml.Save($nugetSpecPath)
}

EnsureNuGetExists
EnsurePythonExists
EnsurePipExists
InstallStoneDependency
EnsureVisualStudioVersion
GenerateProjectFiles
RestoreNugetPackages
UpdateAssemblyInfo
BuildPackages
BuildDoc
UpdateNugetSpec
PackNugetPackage
