// <auto-generated>
// Auto-generated by StoneAPI, do not modify.
// </auto-generated>

namespace Dropbox.Api.TeamLog
{
    using sys = System;
    using col = System.Collections.Generic;
    using re = System.Text.RegularExpressions;

    using enc = Dropbox.Api.Stone;

    /// <summary>
    /// <para>Canceled the team merge.</para>
    /// </summary>
    public class TeamMergeRequestRevokedDetails
    {
        #pragma warning disable 108

        /// <summary>
        /// <para>The encoder instance.</para>
        /// </summary>
        internal static enc.StructEncoder<TeamMergeRequestRevokedDetails> Encoder = new TeamMergeRequestRevokedDetailsEncoder();

        /// <summary>
        /// <para>The decoder instance.</para>
        /// </summary>
        internal static enc.StructDecoder<TeamMergeRequestRevokedDetails> Decoder = new TeamMergeRequestRevokedDetailsDecoder();

        /// <summary>
        /// <para>Initializes a new instance of the <see cref="TeamMergeRequestRevokedDetails"
        /// /> class.</para>
        /// </summary>
        /// <param name="team">The name of the other team.</param>
        public TeamMergeRequestRevokedDetails(string team)
        {
            if (team == null)
            {
                throw new sys.ArgumentNullException("team");
            }

            this.Team = team;
        }

        /// <summary>
        /// <para>Initializes a new instance of the <see cref="TeamMergeRequestRevokedDetails"
        /// /> class.</para>
        /// </summary>
        /// <remarks>This is to construct an instance of the object when
        /// deserializing.</remarks>
        [sys.ComponentModel.EditorBrowsable(sys.ComponentModel.EditorBrowsableState.Never)]
        public TeamMergeRequestRevokedDetails()
        {
        }

        /// <summary>
        /// <para>The name of the other team.</para>
        /// </summary>
        public string Team { get; protected set; }

        #region Encoder class

        /// <summary>
        /// <para>Encoder for  <see cref="TeamMergeRequestRevokedDetails" />.</para>
        /// </summary>
        private class TeamMergeRequestRevokedDetailsEncoder : enc.StructEncoder<TeamMergeRequestRevokedDetails>
        {
            /// <summary>
            /// <para>Encode fields of given value.</para>
            /// </summary>
            /// <param name="value">The value.</param>
            /// <param name="writer">The writer.</param>
            public override void EncodeFields(TeamMergeRequestRevokedDetails value, enc.IJsonWriter writer)
            {
                WriteProperty("team", value.Team, writer, enc.StringEncoder.Instance);
            }
        }

        #endregion


        #region Decoder class

        /// <summary>
        /// <para>Decoder for  <see cref="TeamMergeRequestRevokedDetails" />.</para>
        /// </summary>
        private class TeamMergeRequestRevokedDetailsDecoder : enc.StructDecoder<TeamMergeRequestRevokedDetails>
        {
            /// <summary>
            /// <para>Create a new instance of type <see cref="TeamMergeRequestRevokedDetails"
            /// />.</para>
            /// </summary>
            /// <returns>The struct instance.</returns>
            protected override TeamMergeRequestRevokedDetails Create()
            {
                return new TeamMergeRequestRevokedDetails();
            }

            /// <summary>
            /// <para>Set given field.</para>
            /// </summary>
            /// <param name="value">The field value.</param>
            /// <param name="fieldName">The field name.</param>
            /// <param name="reader">The json reader.</param>
            protected override void SetField(TeamMergeRequestRevokedDetails value, string fieldName, enc.IJsonReader reader)
            {
                switch (fieldName)
                {
                    case "team":
                        value.Team = enc.StringDecoder.Instance.Decode(reader);
                        break;
                    default:
                        reader.Skip();
                        break;
                }
            }
        }

        #endregion
    }
}
