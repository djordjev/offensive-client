package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	import communication.protos.BattleInfo;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class BorderClashes extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const GAMEID:FieldDescriptor$TYPE_INT64 = new FieldDescriptor$TYPE_INT64("communication.protos.BorderClashes.gameId", "gameId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var gameId:Int64;

		/**
		 *  @private
		 */
		public static const BATTLEINFO:RepeatedFieldDescriptor$TYPE_MESSAGE = new RepeatedFieldDescriptor$TYPE_MESSAGE("communication.protos.BorderClashes.battleInfo", "battleInfo", (2 << 3) | com.netease.protobuf.WireType.LENGTH_DELIMITED, function():Class { return communication.protos.BattleInfo; });

		[ArrayElementType("communication.protos.BattleInfo")]
		public var battleInfo:Array = [];

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT64(output, this.gameId);
			for (var battleInfo$index:uint = 0; battleInfo$index < this.battleInfo.length; ++battleInfo$index) {
				com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.LENGTH_DELIMITED, 2);
				com.netease.protobuf.WriteUtils.write$TYPE_MESSAGE(output, this.battleInfo[battleInfo$index]);
			}
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var gameId$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (gameId$count != 0) {
						throw new flash.errors.IOError('Bad data format: BorderClashes.gameId cannot be set twice.');
					}
					++gameId$count;
					this.gameId = com.netease.protobuf.ReadUtils.read$TYPE_INT64(input);
					break;
				case 2:
					this.battleInfo.push(com.netease.protobuf.ReadUtils.read$TYPE_MESSAGE(input, new communication.protos.BattleInfo()));
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
