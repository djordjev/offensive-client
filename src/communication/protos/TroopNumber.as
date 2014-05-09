package communication.protos {
	import com.netease.protobuf.*;
	use namespace com.netease.protobuf.used_by_generated_code;
	import com.netease.protobuf.fieldDescriptors.*;
	import flash.utils.Endian;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	import flash.errors.IOError;
	// @@protoc_insertion_point(imports)

	// @@protoc_insertion_point(class_metadata)
	public dynamic final class TroopNumber extends com.netease.protobuf.Message {
		/**
		 *  @private
		 */
		public static const FIELDID:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.TroopNumber.fieldId", "fieldId", (1 << 3) | com.netease.protobuf.WireType.VARINT);

		public var fieldId:int;

		/**
		 *  @private
		 */
		public static const TROOPNUMBER:FieldDescriptor$TYPE_INT32 = new FieldDescriptor$TYPE_INT32("communication.protos.TroopNumber.troopNumber", "troopNumber", (2 << 3) | com.netease.protobuf.WireType.VARINT);

		public var troopNumber:int;

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function writeToBuffer(output:com.netease.protobuf.WritingBuffer):void {
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 1);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.fieldId);
			com.netease.protobuf.WriteUtils.writeTag(output, com.netease.protobuf.WireType.VARINT, 2);
			com.netease.protobuf.WriteUtils.write$TYPE_INT32(output, this.troopNumber);
			for (var fieldKey:* in this) {
				super.writeUnknown(output, fieldKey);
			}
		}

		/**
		 *  @private
		 */
		override com.netease.protobuf.used_by_generated_code final function readFromSlice(input:flash.utils.IDataInput, bytesAfterSlice:uint):void {
			var fieldId$count:uint = 0;
			var troopNumber$count:uint = 0;
			while (input.bytesAvailable > bytesAfterSlice) {
				var tag:uint = com.netease.protobuf.ReadUtils.read$TYPE_UINT32(input);
				switch (tag >> 3) {
				case 1:
					if (fieldId$count != 0) {
						throw new flash.errors.IOError('Bad data format: TroopNumber.fieldId cannot be set twice.');
					}
					++fieldId$count;
					this.fieldId = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				case 2:
					if (troopNumber$count != 0) {
						throw new flash.errors.IOError('Bad data format: TroopNumber.troopNumber cannot be set twice.');
					}
					++troopNumber$count;
					this.troopNumber = com.netease.protobuf.ReadUtils.read$TYPE_INT32(input);
					break;
				default:
					super.readUnknown(input, tag);
					break;
				}
			}
		}

	}
}
